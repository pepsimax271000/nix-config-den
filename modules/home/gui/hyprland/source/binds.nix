{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       bindle = [
                ", XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
                ", XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
                ", XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
                ", XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"
       ];
       bindl = [
                ", XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
                ", XF86AudioNext, exec, noctalia-shell ipc call media next"
                ", XF86AudioPrev, exec, noctalia-shell ipc call media previous"
                ", XF86AudioPlay, exec, noctalia-shell ipc call media play"
                ", XF86AudioPause, exec, noctalia-shell ipc call media pause"
       ];
       bindm = [
                "SUPER, mouse:272, movewindow"
                "SUPER, mouse:273, resizewindow"
       ];
       bind = [
                "SUPER, Q, killactive"
                "SUPER, F, fullscreen"
                "SUPER shift, Space, togglefloating"
                "SUPER, h, resizeactive, -100 0"
                "SUPER, j, movefocus, l"
                "SUPER, k, movefocus, r"
                "SUPER, l, resizeactive, 100 0"
                "SUPER shift, h, movewindow, l"
                "SUPER shift, j, movewindow, d"
                "SUPER shift, k, movewindow, u"
                "SUPER shift, l, movewindow, r"
                "SUPER ctrl, j, movefocus, d"
                "SUPER ctrl, k, movefocus, u"
                "SUPER, s, pin"
                "SUPER, a, exec, noctalia-shell ipc call bar toggle"
                
                "SUPER, W, exec, uwsm app -- zen-beta.desktop"
                "SUPER, E, exec, noctalia-shell ipc call launcher emoji"
                "SUPER, R, exec, foot -e yazi"
                "SUPER shift, R, exec, uwsm app -- thunar.desktop"
                "SUPER, Y, exec, uwsm app -- discord.desktop"
                "SUPER, U, exec, obs"
                "SUPER, O, exec, uwsm app -- org.prismlauncherPrismLauncher.desktop"
                "SUPER, D, exec, noctalia-shell ipc call launcher toggle"
                "SUPER, backspace, exec, noctalia-shell ipc call lockScreen lock"
                "SUPER shift, C, exec, hyprpicker -a"
                "SUPER, V, exec, noctalia-shell ipc call launcher clipboard"
                "SUPER shift, V, exec, foot -e cava"
                "SUPER, N, exec, uwsm app -- steam.desktop"
                "SUPER, M, exec, foot -e jellyfin-tui"
                "SUPER, Return, exec, foot"
                "SUPER shift, Return, exec, foot"
                ", Print, exec, hyprshot -m region -o ~/Pictures/Screenshots"
                "Ctrl, Print, exec, hyprshot -m region -o - | swappy -f -"
                "SHIFT, Print, exec, hyprshot -m window"
                "Ctrl SHIFT, Print, exec, hyprshot -m window - |  swappy -f -"
                "SUPER, Print, exec, hyprshot -m output"
                "SUPER Ctrl, Print, exec, hyprshot -m output - |  swappy -f -"
                
                
                "SUPER, 1, split-workspace, 1"
                "SUPER, 2, split-workspace, 2"
                "SUPER, 3, split-workspace, 3"
                "SUPER, 4, split-workspace, 4"
                "SUPER, 5, split-workspace, 5"
                "SUPER, 6, split-workspace, 6"
                "SUPER, 7, split-workspace, 7"
                "SUPER, 8, split-workspace, 8"
                "SUPER, 9, split-workspace, 9"
                "SUPER, 0, split-workspace, 10"
                
                "SUPER SHIFT, 1, split-movetoworkspace, 1"
                "SUPER SHIFT, 2, split-movetoworkspace, 2"
                "SUPER SHIFT, 3, split-movetoworkspace, 3"
                "SUPER SHIFT, 4, split-movetoworkspace, 4"
                "SUPER SHIFT, 5, split-movetoworkspace, 5"
                "SUPER SHIFT, 6, split-movetoworkspace, 6"
                "SUPER SHIFT, 7, split-movetoworkspace, 7"
                "SUPER SHIFT, 8, split-movetoworkspace, 8"
                "SUPER SHIFT, 9, split-movetoworkspace, 9"
                "SUPER SHIFT, 0, split-movetoworkspace, 10"
       ];
     };
  };
}
