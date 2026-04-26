{ config, pkgs, ... }:

{
  nix.settings = {

    auto-optimise-store = true;  # Deduplicate identical files
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
}
