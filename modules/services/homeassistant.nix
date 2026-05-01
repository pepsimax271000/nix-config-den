{ ... }: {
  flake.nixosModules.homeassistant = { config, pkgs, ... }: {
    services.caddy.virtualHosts."homeassistant.${config.homelab.domain}".extraConfig = ''
      reverse_proxy "localhost:8080"
    '';
    virtualisation.oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        volumes = [ "home-assistant:/config" ];
        environment.TZ = "Europe/Belfast";
        image = "ghcr.io/home-assistant/home-assistant:stable";
        extraOptions = [ 
          "--network=host"
          # "--device=/dev/ttyACM0:/dev/ttyACM0" ### it *needs* the /dev/ttyACM0 device plugged in or else it will fail to start homeassistant
        ];
      };
    };
  };
}
