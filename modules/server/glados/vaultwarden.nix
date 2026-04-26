{ config, pkgs, ... }:
{
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      config = {
        DOMAIN = "https://vaultwarden.${config.homelab.domain}";
      };
    };
  };
}
