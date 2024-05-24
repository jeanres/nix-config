# Nix Configuration

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

## Services

- SKHD (This allows to focus applications by using key combos)

## Todo

- Manange ssh keys with secrets
