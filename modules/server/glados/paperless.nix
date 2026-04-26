
{ config, pkgs, ... }:
{
  services = { 
    paperless = {
      enable = true;
      user = config.homelab.user;
      dataDir = "${config.homelab.appdataDir}/paperless";
      mediaDir = "${config.homelab.mediaDir}/paperless/media";
      environmentFile = "/home/ye/nix-config/modules/server/glados/paperless-env";
      domain = "${config.homelab.domain}";
    };
  };
}

