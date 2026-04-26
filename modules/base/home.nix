{ self, inputs, lib, ... }: {
  flake.nixosModules.home = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      users.ye = { config, pkgs, ... }: {
        imports = [
          self.homeModules.neovim
        ];
        home.stateVersion = "26.05";
      };
      useGlobalPkgs = true;
      useUserPackages = true;
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
