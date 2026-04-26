{ pkgs, username, ... }:

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

  users.users.${username} = {
    extraGroups = [ "libvirtd" "kvm" ];
  };

  environment.systemPackages = with pkgs; [
    # Virtualization tools
    qemu
    virt-manager
    virt-viewer
    
    # SPICE components
    spice
    spice-gtk
    spice-protocol
    
    # Windows guest support
    virtio-win
    win-spice
  ];
}
