{ config, pkgs, lib, ... }:
{
  services = { 
    jellyfin = {
      enable = true;
      configDir = "${config.homelab.appdataDir}/jellyfin/config";
      logDir = "${config.homelab.appdataDir}/jellyfin/config/log";
      cacheDir = "${config.homelab.appdataDir}/jellyfin/config/cache";
      dataDir = "${config.homelab.appdataDir}/jellyfin";
      user = config.homelab.user;
      group = config.homelab.group;
    };
  };

  nixpkgs.overlays = with pkgs; [
    (
      final: prev:
        {
          jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
            installPhase = ''
              runHook preInstall

              # this is the important line
              sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

              mkdir -p $out/share
              cp -a dist $out/share/jellyfin-web

              runHook postInstall
            '';
          });
        }
    )
  ];

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # Or "i965" if using older driver
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };      # Same here



  systemd.tmpfiles.rules = [
    "d ${config.homelab.appdataDir}/jellyfin 0775 ${config.homelab.user} ${config.homelab.group} -"
    "d ${config.homelab.mediaDir}/movies 0775 ${config.homelab.user} ${config.homelab.group} -"
    "d ${config.homelab.mediaDir}/shows 0775 ${config.homelab.user} ${config.homelab.group} -"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      libva-vdpau-driver # Previously vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-ocl # OpenCL support
    ];
  };
}
