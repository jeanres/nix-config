{ ... }:
{
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      width = 5.0;
      hidpi = "on";
      active_color = "0xff00e5ff"; # cyan (very visible)
      inactive_color = "0xff2f6f73";
    };
  };
}
