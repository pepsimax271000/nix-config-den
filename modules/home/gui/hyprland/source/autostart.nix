{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       exec-once = [
          "udiskie"
          "walker --gapplication-service"
          "openrgb -p asdf"

          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image--watch cliphist store"

          "gnome-keyring-daemon --start --components=secrets"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "hypridle"
          "dbus-update-activation-environment --all"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "/usr/bin/kdeconnectd"
          "hyprpm-reload"

          "[workspace 1 silent] foot"
          "[workspace 2 silent] zen"
          "[workspace 3 silent] steam"
          "[workspace 4 silent] foot -e ncmpcpp"
       ];
     };
  };
}
