{ inputs, nixpkgs, self, username, host, ... }:

{
  imports = [
    ./bootloader.nix
    ./doas.nix
    ./fonts.nix
    ./gaming.nix
    ./lact
    ./libinput.nix
    ./media.nix
    ./mount.nix
    ./networking.nix
    ./nix.nix
    ./program.nix
    ./rgb.nix
    ./services.nix
    ./sops.nix
    ./stylix.nix
    ./system.nix
    ./thunar.nix
    ./udev.nix
    ./user.nix
    ./virtualization.nix
    ./wayland.nix
  ];
}

