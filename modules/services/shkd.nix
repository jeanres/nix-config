{pkgs, ... }:

{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      ctrl - 1 : open /Applications/Safari.app
      ctrl - 2 : open "Users/jeanre.swanepoel/Applications/Home Manager Apps/WezTerm.app"
      ctrl - 3 : open /System/Applications/Freeform.app
      ctrl - 4 : open /System/Applications/Mail.app
      ctrl - 5 : open /System/Applications/Calendar.app
      ctrl - 6 : open /System/Applications/Messages.app
      ctrl - 7 : open /System/Applications/Music.app
      ctrl - 8 : open /Applications/Slack.app
      ctrl - 9 : open "/Applications/Microsoft Teams.app"
    '';
  };
}
