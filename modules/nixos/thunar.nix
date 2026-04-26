{ pkgs, config, ... }:
{
  programs.xfconf.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [ 
    pkgs.ffmpegthumbnailer 
    xarchiver
    thunar-archive-plugin
    thunar-volman
  ];
}
