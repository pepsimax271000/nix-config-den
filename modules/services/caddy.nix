{ ... }: {
  flake.nixosModules.caddy = { config, lib, ... }: {

    systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.secrets.cloudflare-email.path;

    security.acme = {
      acceptTerms = true;
      defaults.email = lib.mkDefault "";
      certs."${config.homelab.domain}" = {
        group = "acme";
        domain = "${config.homelab.domain}";
        extraDomainNames = [ "*.${config.homelab.domain}" ];
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        dnsPropagationCheck = true;
        environmentFile = config.sops.secrets.cloudflare-api.path;
      };
    };
  
    services = {
      caddy = {
        enable = true;
        group = "acme";
        user = "acme";
      };
    };
  };
}

