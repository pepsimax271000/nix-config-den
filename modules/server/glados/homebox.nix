{ config, pkgs, lib, ... }:
{
  services = {
    homebox = {
      enable = true;
      settings = {
        HBOX_OPTIONS_ALLOW_REGISTRATION = "true";
      };
      database.createLocally = true;
    };
  };
}
