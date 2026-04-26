{ ... }: {
  flake.modules.nixos.base = {
    boot.loader.systemd-boot.enable = true;
    networking.networkmanager.enable = true;
    i18n.defaultLocale = "en_GB.UTF-8";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
