{ self, inputs, ... }: {
  flake.nixosConfigurations.beast = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      self.nixosModules.beastConfiguration
    ];
  };

  flake.nixosModules.beastConfiguration = { pkgs, lib, ... }: {
    imports = with self.nixosModules; [
      base
      shell
      desktop
      git
      self.nixosModules.beastHardware
    ];
  };
}
