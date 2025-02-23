{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    autosuggestion = {
      enable = true;
    };
    shellAliases = 
      {
        dr = "darwin-rebuild switch --flake .";
        dt = "dotnet test";
      };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
