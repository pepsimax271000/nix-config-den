{ ... }: {
  flake.nixosModules.vaultwarden = { config, ... }: {
    services.caddy.virtualHosts."vaultwarden.${config.homelab.domain}".extraConfig = ''
      reverse_proxy "localhost:8000"
    '';
    services = {
      vaultwarden = {
        enable = true;
        dbBackend = "sqlite";
        config = {
          DOMAIN = "https://vaultwarden.${config.homelab.domain}";
        };
      };
    };
  };
}
