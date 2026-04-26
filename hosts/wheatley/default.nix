{ config, pkgs, inputs, username, host, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
  ];

  services.nfsClient.enable = true;
  boot = {
    kernelModules = [ "acpi_call" "tp_smapi" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        intel-ocl
        intel-media-sdk
      ];
    };
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };      # Same here

  nixpkgs.overlays = [
    (_self: super: {
      intel-media-sdk = super.intel-media-sdk.overrideAttrs (old: {
        cmakeFlags = old.cmakeFlags ++ ["-DCMAKE_CXX_STANDARD=17"];
        NIX_CFLAGS_COMPILE = "-std=c++17";
      });
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "intel-media-sdk-23.2.2"
  ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "performance";
  };

  services = {
    thermald.enable = true;
    fprintd.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        START_CHARGE_THRESH_BAT0 = 80;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };

    undervolt = {
      enable = true;
      coreOffset = -80;
      gpuOffset = -60;
      uncoreOffset = -80;
      analogioOffset = 0;
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "performance";
        };
        charger = {
          governor = "performance";
        };
      };
    };
  };

  system.stateVersion = "24.11";
} 
