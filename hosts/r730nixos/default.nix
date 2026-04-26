{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
  ];

  boot = {
    kernelParams = [
      "mitigations=off"
      "nowatchdog"
      "quiet"
    ];
  };

  hardware = {
    enableAllFirmware = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
  };

  system.stateVersion = "24.11";
}
