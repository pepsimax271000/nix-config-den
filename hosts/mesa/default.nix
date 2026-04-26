{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
  ];

  boot = {
    kernelModules = [ "acpi_call" "tp_smapi" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi ];
    kernelParams = [
      "i915.enable_rc6=1"
      "i915.enable_fbc=1"
      "mem_sleep_default=deep"
      "pcie_aspm=off"
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver 
        libvdpau-va-gl
        intel-media-driver
      ];
    };
    enableAllFirmware = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        START_CHARGE_THRESH_BAT0 = 80;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };

    fprintd.enable = true;
    auto-cpufreq.enable = true;
  };


  # Essential Tools
  system.stateVersion = "24.11";
}
