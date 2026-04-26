{ config, pkgs, ... }:

{
  # Enable nh (nix helper) for better NixOps management
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      # Keep only the last 5 generations
      extraArgs = "--keep 5";
      # Run daily at 3AM
      dates = "daily 03:00";
    };
    # Use flakes by default
    flake = "/etc/nixos";
  };

  programs.nix-ld.enable = true;

  # Automatic store optimization
  nix.settings = {

    auto-optimise-store = true;  # Deduplicate identical files
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ 
      "ye"
      "root"
    ];
    trusted-users = [
      "ye"
      "root"
      "@wheel"
    ];
    trusted-substituters = [
      "ye"
      "root"
      "@wheel"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  # Additional optimization service
  systemd.services.nh-optimize = {
    description = "Optimize nix store with nh";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.nh}/bin/nh store optimise";
      IOSchedulingClass = "idle";  # Low priority I/O
    };
    startAt = "daily";
  };

  # Emergency cleanup if disk is 90% full
  services.cron.systemCronJobs = [
    ''
    */30 * * * * root if [ $(df /nix/store --output=pcent | tail -n 1 | tr -dc '0-9') -ge 90 ]; then 
      ${pkgs.nh}/bin/nh clean --keep 3 &&
      ${pkgs.nix}/bin/nix-store --optimise
    fi
    ''
  ];

  # Recommended packages
  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor  # Better output during operations
    dust  # For analyzing store usage
  ];
}
