{ pkgs, ... }: {
  flake.homeModules.packages = { pkgs, ... }: {
    home.packages = with pkgs; [ 
      orca-slicer
      pavucontrol
      qbittorrent
      signal-desktop
    ];
  };
}
