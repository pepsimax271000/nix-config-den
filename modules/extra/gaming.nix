{ ... }:
{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        steamtinkerlaunch
        wintricks
        wineWow64Packages.staging
        gamemode
        mangohud
        protonup-qt
        heroic
        protontricks
      ];

      home.packages = with pkgs; [
        (prismlauncher.override {
          jdks = [
            graalvmPackages.graalvm-ce
            zulu
            zulu8
            zulu17
          ];
        })
      ];
      programs = {
        gamemode.enable = true;
        steam = {
          enable = true;
          gamescopeSession.enable = true;
          localNetworkGameTransfers.openFirewall = true;
          package = pkgs.steam.override {
            extraEnv = {
              MANGOHUD = true;
              OBS_VKCAPTURE = true;
            };
          };
        };
      };
      hardware.steam-hardware.enable = true;
    };
}
