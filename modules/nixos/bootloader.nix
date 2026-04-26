{ pkgs, lib, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
  };
}
