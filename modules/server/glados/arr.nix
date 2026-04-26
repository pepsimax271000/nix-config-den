{ config, pkgs, lib, ... }:
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "${config.homelab.appdataDir}/sonarr";
      user = config.homelab.user;
      group = config.homelab.group;
    };

    radarr = {
      enable = true;
      dataDir = "${config.homelab.appdataDir}/radarr";
      user = config.homelab.user;
      group = config.homelab.group;
    };

    prowlarr.enable = true;
    flaresolverr.enable = true;
  };
}

