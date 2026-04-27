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
            self.homeModules.desktop
            #self.homeModules.noctalia
          ];
        };
      }
    ];
  };

  flake.nixosModules.beastConfiguration = { pkgs, lib, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    services.openssh.enable = true;
  };
}
