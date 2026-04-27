{ self, inputs, ... }: {
  flake.nixosConfigurations.beast = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      beastConfiguration
      base
      shell
      desktop
      git
      beastHardware
      homeManager
      {
        home-manager.users.ye = {
          imports = [
            self.homeModules.neovim
          ];
        };
      }
    ];
  };

  flake.nixosModules.beastConfiguration = { pkgs, lib, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}
