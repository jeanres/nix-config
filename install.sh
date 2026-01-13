#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="git@github.com:jeanres/nix-config.git"
CONFIG_DIR="$HOME/.nix-config"
AGE_KEY_DIR="$HOME/.config/sops/age"
AGE_KEY_FILE="$AGE_KEY_DIR/keys.txt"
KEYCHAIN_ACCOUNT="jeanres"
KEYCHAIN_SERVICE="Nix Config Age Key"

# Functions
print_header() {
	echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	echo -e "${BLUE}  $1${NC}"
	echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_step() {
	echo -e "${GREEN}➜${NC} $1"
}

print_warning() {
	echo -e "${YELLOW}⚠${NC}  $1"
}

print_error() {
	echo -e "${RED}✗${NC} $1"
}

print_success() {
	echo -e "${GREEN}✓${NC} $1"
}

check_macos() {
	if [[ "$(uname)" != "Darwin" ]]; then
		print_error "This script is only for macOS"
		exit 1
	fi
}

check_command() {
	if command -v "$1" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

install_homebrew() {
	print_header "Installing Homebrew"

	if check_command brew; then
		print_success "Homebrew already installed"
		return 0
	fi

	print_step "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# Add Homebrew to PATH for Apple Silicon
	if [[ $(uname -m) == "arm64" ]]; then
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	print_success "Homebrew installed successfully"
}

install_nix() {
	print_header "Installing Nix"

	if check_command nix; then
		print_success "Nix already installed"
		return 0
	fi

	print_step "Installing Nix with flakes and nix-command enabled..."
	sh <(curl -L https://nixos.org/nix/install)

	# Source nix profile
	if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
		. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
	fi

	print_success "Nix installed successfully"
}

clone_repo() {
	print_header "Cloning Configuration Repository"

	if [ -d "$CONFIG_DIR" ]; then
		print_warning "Configuration directory already exists at $CONFIG_DIR"
		read -p "Do you want to remove it and clone fresh? (y/N): " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			print_step "Removing existing directory..."
			rm -rf "$CONFIG_DIR"
		else
			print_step "Using existing directory"
			return 0
		fi
	fi

	print_step "Cloning repository..."
	if ! git clone "$REPO_URL" "$CONFIG_DIR"; then
		print_error "Failed to clone repository"
		print_warning "Make sure you have SSH access to the repository"
		print_warning "You may need to set up SSH keys first"
		exit 1
	fi

	print_success "Repository cloned successfully"
}

setup_age_key() {
	print_header "Setting Up Age Encryption Key"

	# Check if age key already exists
	if [ -f "$AGE_KEY_FILE" ]; then
		print_success "Age key already exists at $AGE_KEY_FILE"
		return 0
	fi

	# Try to retrieve from iCloud Keychain
	print_step "Attempting to retrieve age key from iCloud Keychain..."

	if AGE_KEY=$(security find-generic-password -a "$KEYCHAIN_ACCOUNT" -s "$KEYCHAIN_SERVICE" -w 2>/dev/null); then
		print_success "Age key found in iCloud Keychain"

		# Create directory
		mkdir -p "$AGE_KEY_DIR"

		# Save key to file
		echo "$AGE_KEY" >"$AGE_KEY_FILE"
		chmod 600 "$AGE_KEY_FILE"

		print_success "Age key restored to $AGE_KEY_FILE"
		return 0
	fi

	# Key not found in keychain
	print_warning "Age key not found in iCloud Keychain"
	echo
	echo "This could mean:"
	echo "  1. This is your first installation (key needs to be generated)"
	echo "  2. iCloud Keychain hasn't synced yet"
	echo "  3. The key was saved with a different name"
	echo
	read -p "Do you want to generate a new age key? (Y/n): " -n 1 -r
	echo

	if [[ ! $REPLY =~ ^[Nn]$ ]]; then
		print_step "Generating new age key..."

		# Create directory
		mkdir -p "$AGE_KEY_DIR"

		# Generate key using nix-shell
		if ! nix-shell -p age --run "age-keygen -o $AGE_KEY_FILE" 2>&1; then
			print_error "Failed to generate age key"
			exit 1
		fi

		# Get the public key
		PUBLIC_KEY=$(grep "public key:" "$AGE_KEY_FILE" | cut -d: -f2 | tr -d ' ')
		AGE_KEY=$(grep "AGE-SECRET-KEY" "$AGE_KEY_FILE")

		print_success "Age key generated successfully"
		echo -e "${BLUE}Public key: ${NC}$PUBLIC_KEY"

		# Backup to iCloud Keychain
		print_step "Backing up age key to iCloud Keychain..."
		security add-generic-password \
			-a "$KEYCHAIN_ACCOUNT" \
			-s "$KEYCHAIN_SERVICE" \
			-w "$AGE_KEY" \
			-j "Age encryption key for sops-nix. Public key: $PUBLIC_KEY. Created: $(date +%Y-%m-%d)" \
			2>/dev/null || print_warning "Failed to save to keychain (may already exist)"

		print_success "Age key backed up to iCloud Keychain"

		# Update .sops.yaml if it exists
		if [ -f "$CONFIG_DIR/.sops.yaml" ]; then
			print_warning "Remember to update .sops.yaml with your new public key:"
			echo -e "${YELLOW}$PUBLIC_KEY${NC}"
		fi
	else
		print_error "Age key is required for secret decryption"
		print_warning "You can manually add the key to $AGE_KEY_FILE"
		exit 1
	fi
}

build_configuration() {
	print_header "Building Nix Configuration"

	cd "$CONFIG_DIR"

	# Detect hostname
	HOSTNAME=$(hostname -s)
	print_step "Detected hostname: $HOSTNAME"

	# Try to find matching configuration
	if grep -q "\"$HOSTNAME\"" flake.nix; then
		SYSTEM_NAME="$HOSTNAME"
	elif grep -q "Jeanres-MacBook-Pro" flake.nix; then
		SYSTEM_NAME="Jeanres-MacBook-Pro"
		print_warning "Using default configuration: $SYSTEM_NAME"
	else
		print_error "Could not find matching system configuration in flake.nix"
		exit 1
	fi

	print_step "Building configuration for: $SYSTEM_NAME"

	if ! nix build --extra-experimental-features "nix-command flakes" ".#darwinConfigurations.$SYSTEM_NAME.system"; then
		print_error "Failed to build configuration"
		print_warning "Check the error messages above for details"
		exit 1
	fi

	print_success "Configuration built successfully"
}

apply_configuration() {
	print_header "Applying Configuration"

	cd "$CONFIG_DIR"

	print_step "Running darwin-rebuild switch..."
	print_warning "This may take a few minutes..."
	print_warning "You may be prompted for your password (sudo required)"

	if ! sudo ./result/sw/bin/darwin-rebuild switch --flake .; then
		print_error "Failed to apply configuration"
		print_warning "Check the error messages above for details"
		exit 1
	fi

	print_success "Configuration applied successfully"
}

final_instructions() {
	print_header "Installation Complete! 🎉"

	echo
	print_success "Your system has been configured with:"
	echo "  • Nix package manager"
	echo "  • nix-darwin system configuration"
	echo "  • home-manager user environment"
	echo "  • sops-nix secret management"
	echo "  • All development tools and packages"
	echo

	print_step "Next steps:"
	echo "  1. Restart your terminal or run: source ~/.zshrc"
	echo "  2. Check Neovim health: nvim +checkhealth"
	echo "  3. Review configuration: cd ~/.nix-config"
	echo

	print_step "Common commands:"
	echo "  • Update system: darwin-rebuild switch --flake ~/.nix-config"
	echo "  • Edit secrets: cd ~/.nix-config && nix-shell -p sops --run 'sops secrets/secrets.yaml'"
	echo "  • Update packages: nix flake update ~/.nix-config"
	echo "  • Clean old versions: nix-collect-garbage -d"
	echo

	print_step "Documentation:"
	echo "  • README: $CONFIG_DIR/README.md"
	echo "  • Secret management: $CONFIG_DIR/SOPS_GUIDE.md"
	echo "  • Age key reference: $CONFIG_DIR/AGE_KEY_REFERENCE.md"
	echo

	if [ -f "$AGE_KEY_FILE" ]; then
		print_success "Age key location: $AGE_KEY_FILE"
		print_success "Age key backed up to: iCloud Keychain"
	fi

	echo
	print_success "Enjoy your new development environment!"
}

main() {
	clear

	print_header "Nix Configuration Installer"
	echo
	echo "This script will:"
	echo "  1. Install Homebrew (if needed)"
	echo "  2. Install Nix with flakes"
	echo "  3. Clone the configuration repository"
	echo "  4. Setup age encryption key"
	echo "  5. Build and apply the configuration"
	echo
	read -p "Continue with installation? (Y/n): " -n 1 -r
	echo

	if [[ $REPLY =~ ^[Nn]$ ]]; then
		print_warning "Installation cancelled"
		exit 0
	fi

	# Check if running on macOS
	check_macos

	# Install components
	install_homebrew
	install_nix
	clone_repo
	setup_age_key
	build_configuration
	apply_configuration

	# Show final instructions
	final_instructions
}

# Run main function
main
