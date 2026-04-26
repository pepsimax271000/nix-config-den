{ config, pkgs, lib, ... }:
{
  users.users.${config.homelab.user} = {
    isSystemUser = true;
    group = config.homelab.group;
    extraGroups = [ "video" "render" ];
  };

  users.groups.${config.homelab.group} = {};
}
