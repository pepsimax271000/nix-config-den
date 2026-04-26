{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
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
