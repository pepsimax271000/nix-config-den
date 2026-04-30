{ config, self, inputs, ... }:
let
  cfg = self.userConfig;
in {
  flake.nixosModules.base = { config, pkgs, lib, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    users.users = {
      root.hashedPasswordFile = config.sops.secrets.password.path;
      ${cfg.username} = {
        isNormalUser = true;
        home = cfg.homeDir;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.fish;
        hashedPasswordFile = config.sops.secrets.password.path;
      };
    };
    
    nixpkgs.config.allowUnfree = true;
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://hyprland.cachix.org"
	"https://noctalia.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
	"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	"noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets.password = {};
      secrets.password.neededForUsers = true;
    };

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    networking.networkmanager.enable = true;

    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;

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

    fonts = {
      packages = with pkgs; [
        noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-color-emoji
	dejavu_fonts
	liberation_ttf
      ];
    };

    environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
      [Debounce]
      MatchUdevType=mouse
      ModelBouncingKeys=1
    '';

    system.stateVersion = cfg.stateVersion;
  };
}
