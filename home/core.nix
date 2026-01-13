{ pkgs, ... }:

{
  home.shellAliases = {
    cd = "z";
  };
  home.packages = with pkgs; [
    coreutils
  ];
  programs.ripgrep.enable = true;
  programs.jq.enable = true;
  programs.eza = {
    enable = true;
  };
  programs.htop.enable = true;
  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
