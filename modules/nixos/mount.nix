{ config, lib, pkgs, ... }:
let
  cfg = config.services.nfsClient;
in 
{
  options.services.nfsClient = {
    enable = lib.mkEnableOption "NFS Client config";
  };

  config = lib.mkIf cfg.enable {
    # Kernel-level NFS support with modern protocol versions
    boot.supportedFilesystems = [ "nfs" "nfs4" ];
    boot.kernelModules = [ "nfs" "nfsd" ];
    environment.systemPackages = with pkgs; [ nfs-utils ];

    # Essential NFS services
    services = {
      rpcbind.enable = true;
      nfs.server.enable = false;  # Disable if not acting as NFS server
    };

    # Optimized NFS mount with performance tuning
    fileSystems."/media/NAS" = {
      device = "10.1.10.3:/";
      fsType = "nfs4";
      options = [
        # Protocol options
        "nfsvers=4.2"       # Modern protocol version
        "noatime"           # Reduce disk writes
        # Performance tuning
        "rsize=65536"       # Read size (bytes)
        "wsize=65536"       # Write size (bytes)
      ];
    };

    # Auto-mount configuration with fail-safes
    systemd.automounts = [{
      where = "/media/NAS";
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "300";  # More aggressive unmount
        DirectoryMode = "0755";
      };
    }];

    # Kernel network tuning
    boot.kernel.sysctl = {
      "sunrpc.tcp_slot_table_entries" = 128;  # Increase NFS connection slots
      "fs.nfs.nfs_congestion_kb" = 252144;    # 256MB congestion window
    };
  };
}
