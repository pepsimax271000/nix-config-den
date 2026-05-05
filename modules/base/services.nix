{ inputs, ... }:
{
  flake.nixosModules.services =
    { pkgs, ... }:
    {
      services = {
        gvfs.enable = true;
        fwupd.enable = true;
        dbus.enable = true;
        fstrim.enable = true;
        mullvad-vpn = {
          enable = true;
          package = pkgs.mullvad-vpn;
        };
      };
    };
}
