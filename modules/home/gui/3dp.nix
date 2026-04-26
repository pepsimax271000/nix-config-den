{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cura-appimage
    orca-slicer
  ];
}
