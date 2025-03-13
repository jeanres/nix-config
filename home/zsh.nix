{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    autosuggestion = {
      enable = true;
    };
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"


 export PATH=$HOME/Downloads/flutter/bin:$PATH
    '';
    shellAliases = 
      {
        dr = "darwin-rebuild switch --flake .";
        dt = "dotnet test";
        cat = "bat";
      };
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
