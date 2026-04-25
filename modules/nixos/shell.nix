{ pkgs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
    environment.shells = [ pkgs.fish ];
  };
}
