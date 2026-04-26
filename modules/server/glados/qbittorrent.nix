{ config, pkgs, lib, ... }:
{
  services = {
    qbittorrent = {
      enable = true;
      webuiPort = 8080;
      user = config.homelab.user;
      group = config.homelab.group;
      profileDir = "${config.homelab.appdataDir}/qbittorrent";
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences = {
          User = config.homelab.user;
          Group = config.homelab.group;
          Downloads = {
            SavePath = "${config.homelab.mediaDir}/torrents";
          };
          WebUI = {
            AlternativeUIEnabled = true;
            RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
            Username = "adam";
            Password_PBKDF2 = "${config.sops.secrets.qbittorrent_password.path}";
            ServerDomains = "${config.homelab.domain}";
          };
          General.Locale = "en";
        };
      };
    };
  };
}
