# 🚀 Nix Configuration

Personal macOS system configuration using **Nix**, **nix-darwin**, **home-manager**, and **Homebrew**.

This configuration provides a reproducible development environment with encrypted secret management via **sops-nix**.

---

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Fresh Installation](#-fresh-installation)
- [Restore on New Machine](#-restore-on-new-machine)
- [Daily Usage](#-daily-usage)
- [Configuration Structure](#-configuration-structure)
- [Secret Management](#-secret-management)
- [Installed Tools](#-installed-tools)
- [Customization](#-customization)
- [Troubleshooting](#-troubleshooting)

---

## ✨ Features

- 🔄 **Declarative System Configuration** - Entire system defined in code
- 🔐 **Encrypted Secret Management** - SSH keys and tokens encrypted with sops-nix
- 📦 **Optimized Nix Settings** - Binary caches, parallel builds, automatic optimization
- ⚡ **Development Tools** - LSPs, formatters, debuggers for multiple languages
- 🎨 **Neovim IDE Setup** - Comprehensive editor configuration with plugins
- 🔧 **Shell Environment** - zsh, tmux, modern CLI tools (eza, ripgrep, fzf, etc.)
- 🍺 **Homebrew Integration** - GUI apps managed via Homebrew
- 🌐 **Multi-Machine Support** - Variables for easy adaptation to different machines

---

## 📋 Prerequisites

- macOS (tested on Apple Silicon and Intel)
- Internet connection
- Apple ID for iCloud Keychain sync

---

## 🚀 Fresh Installation

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install)
```

### 3. Clone This Repository

```bash
git clone git@github.com:jeanres/nix-config.git ~/.nix-config
cd ~/.nix-config
```

### 4. Update Variables (if needed)

Edit `shared/variables.nix` to match your setup:

```nix
{
  username = "your-username";
  homeDirectory = "/Users/your-username";
}
```

### 5. Generate Age Key for Secrets

```bash
mkdir -p ~/.config/sops/age
nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"

# View your public key
age-keygen -y ~/.config/sops/age/keys.txt
```

**IMPORTANT**: Backup your age key to iCloud Keychain:

```bash
# Replace YOUR_AGE_SECRET_KEY with the key from above
security add-generic-password \
  -a "jeanres" \
  -s "Nix Config Age Key" \
  -w "YOUR_AGE_SECRET_KEY" \
  -j "Age encryption key for sops-nix. Created: $(date +%Y-%m-%d)"
```

### 6. Build the Configuration

```bash
cd ~/.nix-config
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.Jeanres-MacBook-Pro.system
```

### 7. Apply Configuration

```bash
./result/sw/bin/darwin-rebuild switch --flake .
```

### 8. Subsequent Updates

After the first build, use:

```bash
darwin-rebuild switch --flake ~/.nix-config
```

Or for faster rebuilds:

```bash
darwin-rebuild switch --flake ~/.nix-config --fast
```

---

## 🔄 Restore on New Machine

If you're setting up a new Mac with this configuration:

### 1. Install Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Nix
sh <(curl -L https://nixos.org/nix/install)
```

### 2. Clone Repository

```bash
git clone git@github.com:jeanres/nix-config.git ~/.nix-config
cd ~/.nix-config
```

### 3. Restore Age Key from iCloud Keychain

```bash
# Create age directory
mkdir -p ~/.config/sops/age

# Retrieve key from iCloud Keychain (synced from old machine)
security find-generic-password -a "jeanres" -s "Nix Config Age Key" -w > ~/.config/sops/age/keys.txt

# Set correct permissions
chmod 600 ~/.config/sops/age/keys.txt
```

### 4. Build and Apply

```bash
# First build
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.Jeanres-MacBook-Pro.system

# Apply configuration
./result/sw/bin/darwin-rebuild switch --flake .
```

Your SSH keys and all secrets will be automatically decrypted and deployed! 🎉

---

## 💻 Daily Usage

### Making Configuration Changes

1. Edit configuration files in `~/.nix-config`
2. Apply changes:
   ```bash
   darwin-rebuild switch --flake ~/.nix-config
   ```

### Adding Packages

Edit `home/neovim.nix`, `home/core.nix`, or create new module files:

```nix
home.packages = with pkgs; [
  your-package-here
];
```

### Managing Secrets

**Edit encrypted secrets:**
```bash
cd ~/.nix-config
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

**Add new secret:**
1. Edit `secrets/secrets.yaml` (will open in editor)
2. Update `home/sops.nix` to define deployment location
3. Rebuild: `darwin-rebuild switch --flake ~/.nix-config`

See [SOPS_GUIDE.md](SOPS_GUIDE.md) for detailed secret management instructions.

### Common Commands

```bash
# Update flake inputs (update nixpkgs, home-manager, etc.)
nix flake update ~/.nix-config

# Rebuild with updated packages
darwin-rebuild switch --flake ~/.nix-config

# Clean old generations
nix-collect-garbage -d

# Optimize nix store
nix-store --optimise

# Check configuration for errors
nix flake check ~/.nix-config
```

---

## 📁 Configuration Structure

```
~/.nix-config/
├── flake.nix              # Main flake configuration
├── flake.lock             # Locked dependency versions
├── .sops.yaml             # Sops encryption rules
├── README.md              # This file
├── SOPS_GUIDE.md         # Secret management guide
├── AGE_KEY_REFERENCE.md  # Quick reference for age key
│
├── shared/
│   └── variables.nix      # Shared variables (username, paths)
│
├── systems/
│   └── darwin.nix         # macOS system configuration
│
├── modules/
│   └── homebrew.nix       # Homebrew packages & casks
│
├── home/
│   ├── default.nix        # Home-manager entry point
│   ├── core.nix          # Core packages (ripgrep, fzf, etc.)
│   ├── zsh.nix           # Zsh shell configuration
│   ├── git.nix           # Git configuration
│   ├── tmux.nix          # Tmux configuration
│   ├── neovim.nix        # Neovim packages & LSPs
│   ├── sops.nix          # Secret management
│   └── config/
│       ├── neovim/       # Neovim Lua configuration
│       ├── kitty/        # Kitty terminal config
│       ├── yazi/         # Yazi file manager config
│       └── aerospace/    # Aerospace window manager config
│
└── secrets/
    └── secrets.yaml       # Encrypted secrets (SSH keys, tokens)
```

---

## 🔐 Secret Management

This configuration uses **sops-nix** for encrypted secret management.

### Quick Start

**View encrypted secrets:**
```bash
cd ~/.nix-config
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

**Add new secret:**
1. Open secrets file: `sops secrets/secrets.yaml`
2. Add your secret in YAML format
3. Update `home/sops.nix` to deploy it
4. Rebuild system

**Retrieve age key:**
```bash
security find-generic-password -a "jeanres" -s "Nix Config Age Key" -w
```

**Currently Encrypted:**
- SSH private key (id_rsa) → deployed to `~/.ssh/id_rsa`

For complete documentation, see [SOPS_GUIDE.md](SOPS_GUIDE.md) and [AGE_KEY_REFERENCE.md](AGE_KEY_REFERENCE.md).

---

## 🛠 Installed Tools

### System Configuration
- **nix-darwin** - macOS system configuration
- **home-manager** - User environment management
- **sops-nix** - Secret management

### Shell & CLI Tools
- **zsh** - Shell with custom configuration
- **tmux** - Terminal multiplexer
- **starship** - Modern shell prompt
- **eza** - Modern `ls` replacement
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **fzf** - Fuzzy finder
- **zoxide** - Smart `cd` command
- **jq** - JSON processor
- **yazi** - Terminal file manager
- **lazygit** - Git TUI

### Development Tools

#### Language Servers
- **lua-language-server** - Lua LSP
- **nixd** - Nix LSP
- **typescript-language-server** - TypeScript/JavaScript
- **ruby-lsp** - Ruby
- **jdt-language-server** - Java (with Lombok support)
- **marksman** - Markdown
- **gopls** - Go
- **rust-analyzer** - Rust
- **pyright** - Python
- **bash-language-server** - Bash

#### Formatters
- **stylua** - Lua
- **nixfmt** - Nix
- **black** - Python
- **isort** - Python imports
- **prettier** - JavaScript/TypeScript/Markdown
- **rustfmt** - Rust
- **google-java-format** - Java
- **shfmt** - Shell scripts
- **gofmt** - Go (via Go toolchain)
- **csharpier** - C#

#### Debuggers
- **netcoredbg** - C# / .NET debugger

#### Other Dev Tools
- **go** - Go toolchain
- **tree-sitter** - Parser generator tool
- **luarocks** - Lua package manager

### Neovim Plugins

The Neovim configuration includes:

- **blink.cmp** - Completion engine
- **nvim-lspconfig** - LSP integration
- **nvim-treesitter** - Syntax highlighting
- **telescope.nvim** - Fuzzy finder
- **conform.nvim** - Formatting
- **nvim-dap** - Debugging support
- **gitsigns.nvim** - Git integration
- **catppuccin** - Color scheme
- **lualine.nvim** - Status line
- **vim-tmux-navigator** - Tmux integration
- **yazi.nvim** - File manager integration

### Homebrew Applications

GUI applications managed via Homebrew (see `modules/homebrew.nix`):

- **kitty** - Terminal emulator
- **Docker Desktop** - Containerization
- **Aerospace** - Tiling window manager
- **Slack** - Communication
- **OBS** - Screen recording
- **WhatsApp** - Messaging

---

## 🎨 Customization

### Adding New Packages

**System packages:**
Edit `home/neovim.nix` or `home/core.nix`:

```nix
home.packages = with pkgs; [
  # Add your package here
  htop
];
```

**Homebrew apps:**
Edit `modules/homebrew.nix`:

```nix
brews = [
  "your-brew-package"
];

casks = [
  "your-cask-app"
];
```

### Adding Neovim Plugins

Create a new file in `home/config/neovim/lua/plugins/`:

```lua
-- home/config/neovim/lua/plugins/your-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Changing Username/Paths

Edit `shared/variables.nix`:

```nix
{
  username = "your-username";
  homeDirectory = "/Users/your-username";
}
```

Then rebuild:

```bash
darwin-rebuild switch --flake ~/.nix-config
```

---

## 🐛 Troubleshooting

### Build Errors

**Check flake:**
```bash
nix flake check ~/.nix-config
```

**Show detailed trace:**
```bash
darwin-rebuild switch --flake ~/.nix-config --show-trace
```

### Secret Decryption Fails

**Verify age key exists:**
```bash
cat ~/.config/sops/age/keys.txt
```

**Retrieve from keychain:**
```bash
security find-generic-password -a "jeanres" -s "Nix Config Age Key" -w > ~/.config/sops/age/keys.txt
chmod 600 ~/.config/sops/age/keys.txt
```

**Test decryption:**
```bash
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt \
  nix-shell -p sops --run "sops --decrypt ~/.nix-config/secrets/secrets.yaml"
```

### Neovim Issues

**Check health:**
```vim
:checkhealth
```

**Update plugins:**
```vim
:Lazy update
```

### Clean Up Old Generations

```bash
# Delete old system generations
sudo nix-collect-garbage -d

# Delete old home-manager generations
home-manager expire-generations "-7 days"
nix-collect-garbage -d

# Optimize store
nix-store --optimise
```

### Rebuild Takes Too Long

Use the `--fast` flag:
```bash
darwin-rebuild switch --flake ~/.nix-config --fast
```

---

## 📚 Additional Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [nix-darwin Manual](https://daiderd.com/nix-darwin/manual/)
- [home-manager Manual](https://nix-community.github.io/home-manager/)
- [sops-nix Documentation](https://github.com/Mic92/sops-nix)
- [Neovim Documentation](https://neovim.io/doc/)

---

## 📝 Notes

- **Age Key Backup**: Critical for secret decryption. Backed up to iCloud Keychain.
- **Git Commits**: All files in this repo (including encrypted secrets) are safe to commit.
- **System Updates**: Run `nix flake update` to update all dependencies.
- **Performance**: Optimized build settings enable parallel builds and binary caches.

---

## 🤝 Contributing

This is a personal configuration, but feel free to fork and adapt for your own use!

---

## 📄 License

This configuration is provided as-is for personal use.
