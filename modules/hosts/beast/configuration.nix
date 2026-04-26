{ inputs, self, ... }: {
  flake.nixosConfigurations.beast = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      beast 
      home  
    ];
  };

  flake.nixosModules.beast = { pkgs, ... }: {
    imports = with self.nixosModules; [
      base
      home
      shell
      desktop
      git
    ];
  };
}
