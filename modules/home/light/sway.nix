{ config, inputs, pkgs }
{
  wayland.windowManager.sway = {
    enable = true;
  };
  programs.bemenu.enable = true;
}
