{ config, pkgs, ... }:
{
  services = {
    immich = {
      enable = true;
      mediaLocation = "${config.homelab.mediaDir}/immich/photos";
      accelerationDevices = null;
    };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];
}
