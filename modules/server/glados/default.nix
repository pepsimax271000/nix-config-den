{ config, pkgs, lib, ... }:
{
  imports = [
    ./arr.nix
    ./caddy.nix
    ./deluge.nix
    ./homebox.nix
    ./homepage.nix
    ./immich.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./mergerfs.nix
    ./paperless.nix
    ./qbittorrent.nix
    ./share.nix
    ./slskd.nix
    ./users.nix
    ./vaultwarden.nix
  ];
  options.homelab = {
    rootDir = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/user";
      description = "Root directory for homelab services";
    };

    appdataDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.homelab.rootDir}/appdata";
      description = "Directory for application data";
    };

    mediaDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.homelab.rootDir}/media";
      description = "Directory for media files";
    };

    storageDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.homelab.rootDir}/storage";
      description = "Directory for general storage";
    };

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
