{
  flake.nixosModules.base = { pkgs, ... }: {
    
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Belfast";
    i18n.defaultLocale = "en_GB.UTF-8";

    environment.systemPackages = with pkgs; [
      curl
      dust
      fastfetch
      gdu
      killall
      neovim
      nh
      p7zip
      sops
      unrar
      unzip
      wget
    ];

    system.stateVersion = "25.05";
  };
}
