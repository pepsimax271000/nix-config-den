{ self, inputs, ... }: {
  flake.nixosModules.homeManager = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.ye = { config, pkgs, ... }: {
      home.stateVersion = "26.05";
    };
  };
  flake.homeModules.ye = { ... }: {
    programs.home-manager.enable = true;

    home = {
      username = "ye";
      homeDirectory = "/home/ye";
      stateVersion = "26.05";
    };
  };
}
