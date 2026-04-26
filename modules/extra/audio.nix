{ ... }: {
  flake.modules.nixos.audio = {
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
