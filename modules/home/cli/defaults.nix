{ config, pkgs, user, ... }:
{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";

        "image/gif" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/heic" = "imv.desktop";
        "image/heif" = "imv.desktop";

        "video/mp4" = "mpv.desktop";
        "video/avi" = "mpv.desktop";
        "video/mpeg" = "mpv.desktop";
        "video/wmv" = "mpv.desktop";
        "video/flv" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/mp2t" = "mpv.desktop";
      };
    };
    userDirs = {
      createDirectories = true;
      enable = true;
    };
  };
}

