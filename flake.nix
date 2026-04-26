{
  description = "nix-config (flake-parts)";

  inputs = {
    # Core system inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland ecosystem
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Applications / packages
    zen-browser = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:0xc000022070/zen-browser-flake";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    stylix.url = "github:danth/stylix";

    # Extra integrations
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Systems we build for
      systems = [ "x86_64-linux" ];


      perSystem = { system, pkgs, ... }: {
        packages.default = pkgs.hello; # just to satisfy flake check
      };
      flake = let
        # --- Common hardware module definitions ---
        hardwareProfiles = {
          thinkpad = {
            w520 = [ 
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-w520
              inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable
            ];
            t480 = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480 ];
            x230 = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230 ];
            x61  = [ ];
          };

          amd = {
            desktop = [
              inputs.nixos-hardware.nixosModules.common-cpu-amd
              inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
              inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
              inputs.nixos-hardware.nixosModules.common-gpu-amd
            ];
          };

          intel = {
            m93p = [
              inputs.nixos-hardware.nixosModules.common-cpu-intel
              inputs.nixos-hardware.nixosModules.common-gpu-intel
            ];
            z270 = [
              inputs.nixos-hardware.nixosModules.common-cpu-intel
              inputs.nixos-hardware.nixosModules.common-gpu-intel-kaby-lake
            ];
            server = [
              inputs.nixos-hardware.nixosModules.common-cpu-intel
              inputs.nixos-hardware.nixosModules.common-gpu-intel
            ];
          };
        };

        # --- Helper to define each host ---
        mkSystem = { hostname, hostDir, hardwareModules ? [ ], extraModules ? [ ] }:
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              username = "ye";
              host = hostname;
            };
            modules =
              [
                { nixpkgs.config.allowUnfree = true; }

                { nixpkgs.overlays = [
                    (final: prev: {
                      nvchad = inputs.nvchad4nix.packages.x86_64-linux.nvchad;
                    })
                  ];
                }

                hostDir
                inputs.home-manager.nixosModules.home-manager
                inputs.nur.modules.nixos.default
                inputs.disko.nixosModules.disko
                inputs.sops-nix.nixosModules.sops
              ]
              ++ hardwareModules
              ++ extraModules;
          };
      in {
        # --- Home Manager Modules ---
        homeModules = {
          default = ./modules/home;
          minimal = [
            ./modules/home/cli
            ./modules/home/light
          ];
        };

        # --- Host Configurations ---
        nixosConfigurations = {
          heavy     = mkSystem { hostname = "heavy";     hostDir = ./hosts/heavy;     hardwareModules = hardwareProfiles.thinkpad.w520; };
          wheatley  = mkSystem { hostname = "wheatley";  hostDir = ./hosts/wheatley;  hardwareModules = hardwareProfiles.thinkpad.t480; };
          mesa      = mkSystem { hostname = "mesa";      hostDir = ./hosts/mesa;      hardwareModules = hardwareProfiles.thinkpad.x230; };
          atlas     = mkSystem { hostname = "atlas";     hostDir = ./hosts/atlas;     hardwareModules = hardwareProfiles.amd.desktop;   };
          glados    = mkSystem { hostname = "glados";    hostDir = ./hosts/glados;    hardwareModules = hardwareProfiles.intel.server;  };
          chell     = mkSystem { hostname = "chell";     hostDir = ./hosts/chell;     hardwareModules = hardwareProfiles.intel.m93p;   };
          aperture  = mkSystem { hostname = "aperture";  hostDir = ./hosts/aperture;  hardwareModules = hardwareProfiles.intel.z270;   };
          proxvm    = mkSystem { hostname = "proxvm";    hostDir = ./hosts/proxvm;    };
          r730nixos = mkSystem { hostname = "r730nixos"; hostDir = ./hosts/r730nixos; };
        };
      };
    };
}
