{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./../../modules/server/glados
    ./disko-config.nix
  ];

  services.nfsClient.enable = false;

  boot = {
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ 
      "amd_iommu=on" 
      "iommu=pt" 
      "pcie_aspm=off"
      "mitigations=off"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.openssh.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  system.stateVersion = "24.11";
}
