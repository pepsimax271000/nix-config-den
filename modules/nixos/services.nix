{ pkgs, config, ... }:
{
  services = {
    gvfs.enable = true;
    fwupd.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    mullvad-vpn.enable = true;
    mullvad-vpn.package = pkgs.mullvad-vpn;
    gnome = {
      gnome-keyring.enable = true;
    };
  };
}
