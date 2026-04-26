{
  flake.nixosModules.beastHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "ata_generic" "ehci_pci" "ahci" "isci" "xhci_pci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/771f416f-9ab2-4fc7-a3f5-8bd13dec55c6";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };

    fileSystems."/nix" =
      { device = "/dev/disk/by-uuid/771f416f-9ab2-4fc7-a3f5-8bd13dec55c6";
        fsType = "btrfs";
        options = [ "subvol=@nix" ];
      };

    fileSystems."/.snapshots" =
      { device = "/dev/disk/by-uuid/771f416f-9ab2-4fc7-a3f5-8bd13dec55c6";
        fsType = "btrfs";
        options = [ "subvol=@.snapshots" ];
      };

    fileSystems."/home" =
      { device = "/dev/disk/by-uuid/771f416f-9ab2-4fc7-a3f5-8bd13dec55c6";
        fsType = "btrfs";
        options = [ "subvol=@home" ];
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/8109-F978";
        fsType = "vfat";
        options = [ "fmask=0177" "dmask=0077" ];
      };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
