{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
    ./../../modules/server/aperture
  ];

  boot = {
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "mitigations=off"
    ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  system.stateVersion = "24.11";
}
