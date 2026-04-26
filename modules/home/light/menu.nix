{ config, inputs, pkgs }
{
  wayland.windowManager.sway = {
    enable = true;
  }
}
