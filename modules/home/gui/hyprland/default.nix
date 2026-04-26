{ inputs, pkgs, self, config, ... }:
{
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./source
  ];


  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.catppuccin-papirus-folders;
  };
  home.packages = with pkgs; [
    bemoji
    brightnessctl
    cliphist
    direnv
    glib
    grim
    hyprpicker
    hyprshot
    matugen
    playerctl
    swappy
    wayland
    wf-recorder
    wl-clipboard
    wtype
  ];

  #services.hyprsunset = {
  #  enable = true;
  #  transitions = {
  #    sunrise = {
  #      calendar = "*-*-* 06:00:00";
  #      requests = [
  #        [ "temperature" "6500" ]
  #        [ "gamma 100" ]
  #      ];
  #    };
  #    sunset = {
  #      calendar = "*-*-* 22:30:00";
  #      requests = [
  #        [ "temperature" "3500" ]
  #      ];
  #    };      
  #  };
  #};

  #xdg = {
  #  portal = {
  #    enable = true;
  #    xdgOpenUsePortal = true;
  #    extraPortals = [
  #      pkgs.xdg-desktop-portal-gtk
  #    ];
  #    config = {
  #      common.default = [ "gtk" ];
  #      hyprland.default = [
  #        "gtk"
  #        "hyprland"
  #      ];
  #    };
  #  };
  #};
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
    ];

    xwayland = {
      enable = true;
    };
  };
}
