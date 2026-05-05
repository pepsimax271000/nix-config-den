{ ... }:
{
  flake.nixosModules.virtualization =
    { pkgs, ... }:
    {
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
          };
        };
        spiceUSBRedirection.enable = true;
      };

      services.spice-vdagentd.enable = true;

      users.users.ye = {
        extraGroups = [
          "libvirtd"
          "kvm"
        ];
      };

      environment.systemPackages = with pkgs; [
        qemu
        spice
        spice-gtk
        spice-protocol
        virt-manager
        virt-viewer
        virtio-win
        win-spice
      ];
    };
}
