# Nix Darwin Dotfiles

Personal macOS system configuration managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Fresh macOS Installation Guide

### Step 1: Install Xcode Command Line Tools

```bash
xcode-select --install
```

### Step 2: Install Nix (using Lix)

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

After installation, **restart your terminal** or run:

```bash
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### Step 3: Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the on-screen instructions to add Homebrew to your PATH. Typically:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

### Step 4: Clone and Apply Configuration

```bash
# Clone to the expected location
git clone git@github.com:jeanres/nix-config.git ~/.config/nix

# Navigate to the directory
cd ~/.config/nix

# First-time setup - install nix-darwin
nix run nix-darwin/master#darwin-rebuild -- switch --flake .

# For subsequent updates, just use:
make switch
```

### Step 5: Restart Your Computer

Some changes (like window management, keyboard settings) require a full restart to take effect.

### Step 6: Post-Installation

- Open **WezTerm** (your new terminal)
- Open **Aerospace** (window manager) - it should start automatically
- Configure your Aerospace shortcuts (see `~/.config/aerospace/aerospace.toml`)
- Install your preferred Neovim plugins by opening nvim and running `:Lazy sync`

## Updating an Existing Installation

```bash
cd ~/.config/nix

# Update all packages to latest versions
make update

# Apply the updated configuration
make switch
```

## Structure

```
.
├── flake.nix              # Main nix flake entry point
├── hosts/                 # Host-specific configurations
│   └── jeanres-macbook-pro/
├── home/                  # Home configuration
│   ├── config/           # Config files (neovim, wezterm, aerospace, tmux)
│   ├── programs/         # Program configurations
│   └── services/         # Service configurations
└── scripts/              # Helper scripts
```

## Tools Included

### Shell & Terminal

- **zsh** with vi keybindings and syntax highlighting
- **wezterm** terminal emulator
- **starship** prompt
- **tmux** terminal multiplexer
- **fzf** fuzzy finder
- **zoxide** smart cd
- **eza** modern ls replacement
- **bat** syntax-highlighted cat

### Window Management

- **aerospace** tiling window manager (macOS)
- **jankyborders** window borders

### Editor

- **Neovim** with extensive LSP support:
  - Lua, Nix, TypeScript, Java, Python, Rust, Go, Bash
  - Telescope, Neo-tree, Neo-git, Conform, Treesitter

### Development Tools

- **git** with aliases and settings
- **direnv** environment management
- **yazi** terminal file manager
- **ripgrep**, **jq**, **fd** utilities

### Homebrew Casks

- Docker Desktop
- Slack
- WhatsApp
- UTM (virtualization)
- OBS
- Nerd Fonts

## Usage

```bash
make help     # Show available commands
make switch   # Apply configuration
make update   # Update flake.lock
```
