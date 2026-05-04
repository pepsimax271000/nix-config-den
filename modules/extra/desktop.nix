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
    services.hypridle = {
      enable = true;
      settings = {
        general = {
	  lock_cmd = "pidof noctalia || noctalia-shell ipc call lockScreen lock";
	  before_sleep_cmd = "loginctl lock-session";
	  after_sleep_cmd = "hyprctl dispatch dpms on";
	};

	listener = [
	  {
	    timeout = 300;
	    on-timeout = "brightnessctl -s set 10";
	    on-resume = "brightnessctl -r";
	  }
	  {
	    timeout = 1800;
	    on-timeout = "loginctl lock-session";
	  }
	  {
	    timeout = 1500;
	    on-timeout = "hyprctl dispatch dpms off";
	    on-resume= "hyprctl dispatch dpms on";
	  }
	  {
	    timeout = 4500;
	    on-timeout = "systemctl suspend";
	  }
	];
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
          "$mod Shift, Space, togglefloating"
          "$mod, h, resizeactive, -100 0"
          "$mod, j, movefocus, l"
          "$mod, k, movefocus, r"
          "$mod, l, resizeactive, 100 0"
          "$mod Shift, h, movewindow, l"
          "$mod Shift, j, movewindow, d"
          "$mod Shift, k, movewindow, u"
          "$mod Shift, l, movewindow, r"
          "$mod Ctrl, j, movefocus, d"
          "$mod Ctrl, k, movefocus, u"
          "$mod, Return, exec, foot"
	  "$mod, Backspace, exec, noctalia-shell ipc call lockScreen lock"
          "$mod, Q, killactive"
          "$mod, W, exec, zen-beta"
	  "$mod, E, exec, noctalia-shell ipc call launcher emoji"
	  "$mod, R, exec, foot -e yazi"
          "$mod, A, exec, noctalia-shell ipc call bar toggle"
          "$mod, S, pin"
	  "$mod, D, exec, noctalia-shell ipc call launcher toggle"
          "$mod, F, exec, fullscreen"
	  "$mod, V, exec, noctalia-shell ipc call launcher clipboard"
	  "$mod, M, exec, foot -e jellyfin-tui"
          "$mod, 1, split-workspace, 1"
          "$mod, 2, split-workspace, 2"
          "$mod, 3, split-workspace, 3"
          "$mod, 4, split-workspace, 4"
          "$mod, 5, split-workspace, 5"
          "$mod, 6, split-workspace, 6"
          "$mod, 7, split-workspace, 7"
          "$mod, 8, split-workspace, 8"
          "$mod, 9, split-workspace, 9"
          "$mod Shift, 1, split-movetoworkspace, 1"
          "$mod Shift, 2, split-movetoworkspace, 2"
          "$mod Shift, 3, split-movetoworkspace, 3"
          "$mod Shift, 4, split-movetoworkspace, 4"
          "$mod Shift, 5, split-movetoworkspace, 5"
          "$mod Shift, 6, split-movetoworkspace, 6"
          "$mod Shift, 7, split-movetoworkspace, 7"
          "$mod Shift, 8, split-movetoworkspace, 8"
          "$mod Shift, 9, split-movetoworkspace, 9"
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
