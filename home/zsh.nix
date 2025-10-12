{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
KEYTIMEOUT=1 
# Set cursor to underscore (steady underline) in insert mode
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    # Normal mode → block
    printf '\e[2 q'
  else
    # Insert mode → underscore
    printf '\e[4 q'
  fi
}

# Also reset on startup
function zle-line-init {
  zle -K viins
  printf '\e[4 q'
}

zle -N zle-keymap-select
zle -N zle-line-init
    '';
    shellAliases = 
      {
        dr = "sudo darwin-rebuild switch --flake .#Jeanres-MacBook-Pro";
        cat = "bat";
      };
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
