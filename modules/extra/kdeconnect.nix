{ ... }:
{
  flake.nixosModules.kdeconnect =
    { pkgs, ... }:
    {
      services = {
        kdeconnect.enable = true;
      };
    };
}
