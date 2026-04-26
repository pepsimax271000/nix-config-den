{ pkgs, config, ... }:
{
  programs = {
    fish.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  environment.systemPackages = with pkgs; [
    bc
    ffmpeg
    gdu
    p7zip
    killall
    sops
    unetbootin
    unrar
    unzip
    vulkan-tools
  ];
}
