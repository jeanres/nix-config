{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    shellAliases = 
      {
        dr = "darwin-rebuild switch --flake .";
        cat = "bat";
      };
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
