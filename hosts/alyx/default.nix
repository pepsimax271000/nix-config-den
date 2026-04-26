{ lib, config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  boot = {
    kernelParams = [
      "acpi_osi=Linux"
      "pcie_aspm=off" 
      "i915.modeset=1"
      "consoleblank=30"
    ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
        useOSProber = true;
      };
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ vaapiIntel ];
    };
    firmware = [ pkgs.firmwareLinuxNonfree ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  services = {
    thermald.enable = true;
  };

  system.stateVersion = "24.11"
}
