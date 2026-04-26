{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WDS500G2B0A-00SM50_2043A6444106"; # Change this to your disk device
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%"; # Uses remaining space
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # Force creation
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [ "noatime" "compress-force=zstd:2" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "noatime" "compress-force=zstd:2" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "noatime" "compress-force=zstd:2" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
