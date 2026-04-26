{ self, inputs, config, ... }: {
  flake.nixosModules.base = { pkgs, lib, ... }: {

    users.users.ye = {
      isNormalUser = true;
      home = "/home/ye";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.fish;
    };
    
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    system.stateVersion = "25.05";
  };
}
