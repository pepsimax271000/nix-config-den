{ ... }: {
  flake.nixosModules.unifi = { config, pkgs, ... }: {
    services.caddy.virtualHosts."unifi.${config.homelab.domain}".extraConfig = ''
      reverse_proxy "localhost:8443"
    '';

    networking.firewall = {
      allowedUDPPorts = [ 8443 ];
      allowedTCPPorts = [ 8443 ];
    };
    services = {
      unifi = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
