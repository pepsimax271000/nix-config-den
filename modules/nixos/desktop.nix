{ ... }: {
  flake.nixosModules.desktop = { ... }: {
    programs.hyprland.enable = true;
    hardware.graphics.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
  };
}
