{ self, lib, ... }: {
  flake.nixosModules.userConfig = rec {
    username    = "ye";
    email       = "248238336+pepsimax271000@users.noreply.github.com";
    gitName     = "pepsimax271000";
    homeDir     = "/home/${username}";
    timezone    = "Europe/Belfast";
    locale      = "en_GB.UTF-8";
    stateVersion = "26.05";
  };
}
