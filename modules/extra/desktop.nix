{ ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    programs.hyprland.enable = true;
    hardware.graphics.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
  };

  flake.modules.homeManager.desktop = { pkgs, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = ",preffered,auto,1";
        "$mod" = "SUPER";
        bind = [
          "$mod, Return, exec, foot"
          "$mod, Q, exec, killactive"
          "$mod, W, exec, zen-beta"
          "$mod, F, exec, fullscreen"
          "$mod, 1, exec, workspace, 1"
          "$mod, 2, exec, workspace, 2"
        ];
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 2;
        };
        input = {
          kb_layout = "gb";
        };
      };
    };
  };
}
