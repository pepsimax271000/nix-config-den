{ self, inputs, ... }:
{
  flake.nixosModules.services =
    { pkgs, lib, ... }:
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
