{ ... }: {
  flake.nixosModules.base = { lib, ... }: {
    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
	default = "ye";
      };
      stateVersion = lib.mkoption {
        type = lib.types.str;
	default = "25.11";
      };
  };
}
