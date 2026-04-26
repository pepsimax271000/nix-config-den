{ config, pkgs, lib, ... }:
{
  services = {
    jellyseerr = {
      enable = true;
    };
  };
}
