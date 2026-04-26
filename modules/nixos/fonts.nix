{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts 
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.caskaydia-cove
      dejavu_fonts
      liberation_ttf
      terminus_font_ttf
      nerd-fonts.departure-mono
      cozette
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Caskaydia Cove Nerd Font"];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    };
  };
}
