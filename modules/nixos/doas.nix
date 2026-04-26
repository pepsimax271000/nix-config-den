{
  config,
  pkgs,
  ...
}: {
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          cmd = "nixos-rebuild";
          keepEnv = true;
          persist = true;
        }
        {
          groups = ["wheel"];
          cmd = "nixos-rebuild";
          noPass = true;
        }
      ];
    };
  };
}
