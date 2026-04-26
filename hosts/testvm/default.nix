{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "mitigations=off"
      "nowatchdog"
      "quiet"
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  services = {
    smartd.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };
  };

  system.stateVersion = "24.11";
}
