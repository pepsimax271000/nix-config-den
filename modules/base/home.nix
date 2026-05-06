{
  config,
  inputs,
  ...
}:
{
  flake.nixosModules.homeManager =
    { ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${config.my.username} =
        { ... }:
        {
          home.stateVersion = config.my.stateVersion;
        };
    };
  flake.homeModules.${config.my.username} =
    { ... }:
    {
      programs.home-manager.enable = true;

      home = {
        username = config.my.username;
        homeDirectory = config.my.homeDir;
        stateVersion = config.my.stateVersion;
      };
    };
}
