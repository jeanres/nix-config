{ ... }:
{
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
    shellAliases = {
      # Full system rebuild (very common on nix-darwin)
      dr = "sudo darwin-rebuild switch --flake .#Jeanres-MacBook-Pro";

      # Modern, syntax-highlighted cat replacement (very popular)
      cat = "bat";

      # Smart tmux session = directory-based (lowercase, alphanumeric + hyphen only)
      t = ''
        session_name=$(basename "$PWD" | tr "[:upper:]" "[:lower:]" | tr -cd "[:alnum:]-")
        tmux attach-session -t "$session_name" 2>/dev/null || tmux new-session -s "$session_name"
      '';
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
