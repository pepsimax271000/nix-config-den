{
  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "table";
          format = "msdos"; # MBR partition table
          partitions = [
            {
              name = "boot";
              start = "1MiB";
              end = "2GiB"; # 2GB for boot
              bootable = true; # Mark bootable for MBR
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            }
            {
              name = "root";
              start = "2GiB";
              end = "100%"; # Use remaining space
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Force format
                subvolumes = {
                  "root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            }
          ];
        };
      };
    };
  };
}
