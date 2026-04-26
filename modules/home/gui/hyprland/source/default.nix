{ inputs, ... }:
{
  imports = [
    ./appearance.nix
    ./autostart.nix
    ./binds.nix
    ./env.nix
    ./general.nix
    ./input.nix
    ./misc.conf
    ./monitors.nix
    ./windowrules.nix
  ];
}
