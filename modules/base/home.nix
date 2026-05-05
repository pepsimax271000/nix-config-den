{ self, inputs, ... }:
let
  cfg = self.userConfig;
in
{
  flake.nixosModules.homeManager =
    { ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${cfg.username} =
        { ... }:
        {
          home.stateVersion = cfg.stateVersion;
        };
    };
  flake.homeModules.${cfg.username} =
    { ... }:
    {
      programs.home-manager.enable = true;

      home = {
        username = cfg.username;
        homeDirectory = cfg.homeDir;
        stateVersion = cfg.stateVersion;
      };
    };
}
