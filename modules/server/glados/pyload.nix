{ config, pkgs, lib, ... }:
{
  services = {
    pyload = {
      enable = true;
      user = config.homelab.user;
      group = config.homelab.group;
      downloadDirectory = "${config.homelab.mediaDir}/Downloads"
    };
  }:
}
