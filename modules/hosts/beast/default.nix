{ config, self, inputs, ... }: {
  flake.nixosConfigurations.beast = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      beastConfiguration
      base
      git
      services
      shell
      stylix
      audio
      desktop
      virtualization
      beastHardware
      homeManager
      {
        home-manager.users.ye = {
          imports = [
	    self.homeModules.browser
	    self.homeModules.packages
            self.homeModules.desktop
            self.homeModules.neovim
            self.homeModules.noctalia
            self.homeModules.shell
          ];
        };
      }
    ];
  };

  flake.nixosModules.beastConfiguration = { config, pkgs, lib, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      modesetting.enable = true;
      open = false;
    };
    networking.hostName = "beast";
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    services.openssh.enable = true;
  };
}
