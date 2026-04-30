{ inputs, lib, ... }: {
  flake.nixosModules.desktop = { pkgs, lib, ... }: {
    hardware.graphics.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
  };

  flake.homeModules.desktop = { config, pkgs, ... }: {
    programs = {
      foot = {
        enable = true;
	settings = {
	  key-bindings = {
	    scrollback-down-page = "Mod1+j";
	    scrollback-up-page = "Mod1+k";
	    clipboard-copy = "Mod1+c";
	    clipboard-paste = "Mod1+v";
	    font-decrease = "Mod1+Shift+j";
	    font-increase = "Mod1+Shift+k";
	    font-reset = "Mod1+Shift+l";
	    search-start = "Mod1+slash";
	  };
	  main.pad = "0x0";
	};
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
      ];
      settings = {
        monitor = ",preffered,auto,1";
        "$mod" = "SUPER";
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
	  "$mod, Q, killactive"
          "$mod, F, fullscreen"
          "$mod shift, Space, togglefloating"
          "$mod, h, resizeactive, -100 0"
          "$mod, j, movefocus, l"
          "$mod, k, movefocus, r"
          "$mod, l, resizeactive, 100 0"
          "$mod shift, h, movewindow, l"
          "$mod shift, j, movewindow, d"
          "$mod shift, k, movewindow, u"
          "$mod shift, l, movewindow, r"
          "$mod ctrl, j, movefocus, d"
          "$mod ctrl, k, movefocus, u"
          "$mod, s, pin"
          "$mod, a, exec, noctalia-shell ipc call bar toggle"
          "$mod, Return, exec, foot"
          "$mod, Q, killactive"
          "$mod, W, exec, zen-beta"
	  "$mod, E, exec, noctalia-shell ipc call launcher emoji"
	  "$mod, R, exec, foot -e yazi"
	  "$mod, D, exec, noctalia-shell ipc call launcher toggle"
          "$mod, F, exec, fullscreen"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod shift, 1, movetoworkspace, 1"
          "$mod shift, 2, movetoworkspace, 2"
          "$mod shift, 3, movetoworkspace, 3"
          "$mod shift, 4, movetoworkspace, 4"
          "$mod shift, 5, movetoworkspace, 5"
          "$mod shift, 6, movetoworkspace, 6"
          "$mod shift, 7, movetoworkspace, 7"
          "$mod shift, 8, movetoworkspace, 8"
          "$mod shift, 9, movetoworkspace, 9"
        ];
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 3;
	  "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base09})";
	  "col.inactive_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base04})";
        };
	animations.enabled = false;
	decoration = {
	  shadow = {
	    enabled = true;
	    offset = "5 5";
	    color = lib.mkForce "rgba(${config.lib.stylix.colors.base00}ff)";
	  };
	};
        input = {
          kb_layout = "gb";
	  kb_options = "ctrl:nocaps";
	  repeat_delay = "300";
	  repeat_rate = "50";
        };
	exec-once = [
	  "noctalia-shell"
	];
      };
    };
  };
}
