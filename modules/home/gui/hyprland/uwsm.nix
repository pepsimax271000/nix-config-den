{ inputs, pkgs, outputs, ... }:
{
  programs.uwsm = {
    enable = true;
    export = {
    "HYPRCURSOR_THEME" = "Bibata Modern Classic";
    "HYPRCURSOR_SIZE" = "24";
    "QT_QPA_PLATFORM" = "wayland";
    "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
    "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
    };
  };
}


