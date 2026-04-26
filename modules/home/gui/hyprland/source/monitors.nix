{ ... }:
{
  wayland.windowManager.hyprland = {
    extraConfig = "
      monitor=DP-1,3440x1440@165.0,1270x1080,1.0
      monitor=DP-2,1920x1080@120.0,1963x0,1.0
      monitor=DP-3,1920x1200@60.0,70x787,1.0
      monitor=DP-3,transform,3
      monitor=eDP-1,3840x2160@60,auto,1.5
      monitor=LVDS-1,1920x1080@60,auto,1
    ";
 };
}
