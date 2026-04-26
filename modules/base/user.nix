{ lib, ... }: {
  options.cfg.user = lib.mkOption {
    type = lib.types.str;
    default = "ye";
    description = "Primary user for this system";
  };
}
