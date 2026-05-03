{ ... }: {
  flake.nixosModules.arr = { config, pkgs, ... }: {
    services.caddy.virtualHosts = {
      "radarr.${config.homelab.domain}".extraConfig = ''
        reverse_proxy "localhost:7878"
      '';
      "sonarr.${config.homelab.domain}".extraConfig = ''
        reverse_proxy "localhost:8989"
      '';
      "prowlarr.${config.homelab.domain}".extraConfig = ''
        reverse_proxy "localhost:9696ZZ9696ZZ9696ZZ9696ZZ9696ZZ9696ZZ9696ZZ9696ZZ9696ZZ"
      '';
    };

    networking.firewall = {
      allowedUDPPorts = [ 
        7878
	      8989
	      9696
      ];
      allowedTCPPorts = [ 
        7878
	      8989
	      9696
      ];
    };
    services = {
      radarr = {
        enable = true;
	      dataDir = "${config.homelab.appdataDir}/radarr";
      };
      sonarr = {
        enable = true;
	      dataDir = "${config.homelab.appdataDir}/sonarr";
      };
      prowlarr = {
        enable = true;
	      dataDir = "${config.homelab.appdataDir}/prowlarr";
      };
      flaresolverr = {
        enable = true;
      };
    };
  };
}
