# Nix Configuration

Configuration for MacOS using nix, nix-darwin, home-manager and homebrew

## Install Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install Nix

```
sh <(curl -L https://nixos.org/nix/install)
```

## Clone the repository

```
git clone git@github.com:jeanres/nix-config.git ~/.nix-config
```

## Build the configuration

```
cd ~/.nix-config
nix build --extra-experimental-features "nix-command flakes" .\#darwinConfigurations.<hostname>.system
```

## Build Nix-Darwin

```
./result/sw/bin/darwin-rebuild switch --flake .
```

When making a change to the configuration you can run 

```
darwin-rebuild switch --flake .
```

## Shell Applications

- WezTerm
- Neovim
- Tmux

# Homebrew Applications
 
- Docker
- Vimari (Vim keybindings for Safari)
- Obs and Obs-ndi
- TablePlus

New applications can be added to ```modules/homebrew.nix```

## Services

- SKHD (This allows to focus applications by using key combos)

## Neovim Configuration

### Neovim Plugins

- arrow
- cmp
- comment
- conform
- copilot
- fugitive
- gitsigns
- lsp
- lualine
- oil
- telescope
- treesitter
- vim-sleuth
- vim-tmux-navigator
- vim-wiki

Adding plugins can be done by creating a new lua file in ```home/neovim/lua/plugins```

#### Plugin Example

```
return { 
	"nyoom-engineering/oxocarbon.nvim",
	config = function()
		vim.opt.background = "dark" -- set this to dark or light
		vim.cmd("colorscheme oxocarbon")
	end,
}
```

#### Settings

Settings for neovim can be changed in ```home/neovim/lua/config/set.lua```

## Todo

- Manange ssh keys with secrets
