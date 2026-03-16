{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };
    defaultKeymap = "viins";
    initContent = ''
      # Allow backspace/CTRL-H to delete past the point insert mode was entered
      bindkey -M viins '^?' backward-delete-char
      bindkey -M viins '^H' backward-delete-char

      # Press v to edit command line in text editor
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd v edit-command-line
    '';
    shellAliases = {
      cat = "bat";
      t = ''
        session_name=$(basename "$PWD" | tr "[:upper:]" "[:lower:]" | tr -cd "[:alnum:]-")
        tmux attach-session -t "$session_name" 2>/dev/null || tmux new-session -s "$session_name"
      '';
      cd = "z";
    };
  };
  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
    };
  };
  programs.direnv.enable = true;
}
