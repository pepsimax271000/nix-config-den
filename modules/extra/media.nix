{ pkgs, ... }: {
  flake.nixosModules.media = { pkgs, ... }: {
    home.packages = with pkgs; [ 
      jellyfin-tui
      imv
      ffmpeg
    ];

    programs = {
      mpv.enable = true;
      yt-dlp.enable = true;
      zathura.enable = true;
    };
  };
}
