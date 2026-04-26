{
  flake.nixosModules.desktop = { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "ata_generic" "ehci_pci" "ahci" "isci" "xhci_pci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
