{ inputs, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mangohud 
    protonup-qt 
    lutris 
    bottles 
    heroic
    protontricks
    winetricks
 	  nur.repos.iuricarras.truckersmp-cli
  ];
}
