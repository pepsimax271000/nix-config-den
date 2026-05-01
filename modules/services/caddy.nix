{ ... }: {
  flake.nixos modules.caddy = { config, ... }:
    security.acme = {
      acceptTerms = true;
      defaults.email = builtins.readFile email;
      certs."${config.homelab.domain}" = {
        domain = config.homelab.domain;
        extraDomainNames = [ "*.${config.homelab.domain}" ];
        dnsProvider = "cloudflare";
        group = "acme";
        dnsResolver = "1.1.1.1:53";
        dnsPropagationCheck = true;
        environmentFile = api;
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
