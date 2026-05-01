{ ... }: {
  flake.nixosModules.servicesConfig = { lib, ... }: {
    options.homelab = {
      domain = lib.mkOption { type = lib.types.str; default = "tjd.lol"; };
    };
  };
}
