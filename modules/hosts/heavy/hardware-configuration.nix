{
  flake.nixosModules.heavyHardware= { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "ata_generic" "ehci_pci" "ahci" "isci" "xhci_pci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/261b7b72-5359-4405-ac9b-5821722e7ebe";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };

    fileSystems."/nix" =
      { device = "/dev/disk/by-uuid/261b7b72-5359-4405-ac9b-5821722e7ebe";
        fsType = "btrfs";
        options = [ "subvol=@nix"  ];
      };

    fileSystems."/.snapshots" =
      { device = "/dev/disk/by-uuid/261b7b72-5359-4405-ac9b-5821722e7ebe";
        fsType = "btrfs";
        options = [ "subvol=@.snapshots" ];
      };

    fileSystems."/home" =
      { device = "/dev/disk/by-uuid/261b7b72-5359-4405-ac9b-5821722e7ebe";
        fsType = "btrfs";
        options = [ "subvol=@home" ];
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/5EE9-01AF";
        fsType = "vfat";
        options = [ "fmask=0177" "dmask=0077" ];
      };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
