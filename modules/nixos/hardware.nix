{ inputs, pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
     }; 
    };
    hardware.enableRedistributableFirmware = true;
}
