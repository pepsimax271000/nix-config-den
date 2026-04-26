{ config, pkgs, lib, ... }:
{
  imports = [
    ./dns.nix
    ./unifi.nix
    ./homeassistant.nix
  ];
  options.homelab = {
    user = lib.mkOption {
      type = lib.types.str;
      default = "share";
      description = "User for running services";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "share";
      description = "Group for running services";
    };

    domain = lib.mkOption {
      type = lib.types.str;
      default = "tjd.lol";
      description = "Base domain for services";
    };
  };

}
