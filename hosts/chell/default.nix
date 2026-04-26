{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./../../modules/nixos
    ./../../modules/server/chell
  ];

  boot = {
    kernelParams = [
      "i915.enable_rc6=1"
      "i915.enable_fbc=1"
      "mitigations=off"
    ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver
        libvdpau-va-gl
        intel-media-driver
      ];
      enable32Bit = true;
    };
    enableAllFirmware = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  services = {
    thermald.enable = true;
  };

  system.stateVersion = "24.11";
}
