{ config, pkgs, ... }:
{
  services = {
    deluge = {
      enable = true;
      web.enable = true;
      declarative = true;
      dataDir = "${config.homelab.appdataDir}/deluge";
      authFile = "${config.sops.secrets.deluge.path}";
      group = config.homelab.group;
      user = config.homelab.user;
      config = {
        download_location = "${config.homelab.mediaDir}/torrents";
        pre_allocate_storage = true;
        sequential_download = true;
        max_active_seeding = "15";
        max_active_downloading = "30";
        max_active_limit = "50";
      };
    };
  };
}
