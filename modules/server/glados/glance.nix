{ config, pkgs, lib, ... }:
{
  services = {
    glance = {
      enable = true;
      settings = {
        - name: Startpage
          width: slim
          hide-desktop-navigation: true
          center-vertically: true
          columns:
            - size: full
              widgets:
                - type: search
                  autofocus: true
                - type: monitor
                  cache: 1m
                  title: Services
                  sites:
                    - title: Jellyfin
                      url: https://jellyfin.tjd.lol/
                      icon: si:jellyfin
                    - title: Home Assistant
                      url: https://homeassistant.tjd.lol/
                      icon: si:gitea
                    - title: Deluge # only for Linux ISOs, of course
                      url: https://deluge.tjd.lol/
                      icon: si:qbittorrent
                    - title: Immich
                      url: https://immich.tjd.lol/
                      icon: si:immich
                    - title: AdGuard Home
                      url: https://adguard.tjd.lol/
                      icon: si:adguard
                    - title: Vaultwarden
                      url: https://vaultwarden.tjd.lol/
                      icon: si:vaultwarden
      };
    };
  };
}
