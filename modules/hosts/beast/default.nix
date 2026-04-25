{ config, inputs, ... }:
let inherit (config.flake.common) username stateVersion system;
in {
  flake.nixosConfigurations.beast = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      config.flake.nixosModules.base
      config.flake.nixosModules.shell
      config.flake.nixosModules.desktop
      config.flake.diskoConfigurations.beast
      { networking.hostname = "beast";
        system.stateVersion = stateVersion; }
    ];
  };
}
