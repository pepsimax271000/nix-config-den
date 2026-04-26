{ inputs, username, host, ...}: {
  imports = [
    ./3dp.nix
    ./browser.nix
    ./easyeffects.nix
    ./foot.nix
    ./gaming.nix
    ./hyprland
    ./imv.nix
    ./kdeconnect.nix
    #./kicad.nix
    ./krita.nix
    ./mpv.nix
    ./noctalia.nix
    ./obs.nix
    ./prism.nix
    ./qbittorrent.nix
    ./signal.nix
    ./vial.nix
    ./zathura.nix
  ];
}
