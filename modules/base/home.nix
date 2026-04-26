{ config, inputs, self, ... }: {
  flake.nixosModules.home = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.cfg.user} = { ... }: {
        home.stateVersion = "25.05";
      };
    };
  };
}
