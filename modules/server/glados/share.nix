{ config, pkgs, ... }:
{
  fileSystems."/export/share" = {
    device = "/mnt/user";
    options = [ "bind" ];
  };

  services = {
    nfs = {
      server = {
        enable = true;
        exports = ''
          /export/share 10.1.10.0/24(rw,sync,nohide,insecure,fsid=0,no_subtree_check)
          /export/share 10.1.10.0/24(rw,sync,nohide,insecure,fsid=0,no_subtree_check)
        '';
      };
    };
    samba = {
      enable = true;
      package = pkgs.samba4Full;
      settings = {
        global = {
          workgroup = "WORKGROUP";
          security = "user";
          interfaces = "lo enp3s0";
          "browseable" = "yes";
          "client min protocol" = "core";
          "server min protocol" = "core";
          "passwd program" = "/run/wrappers/bin/passwd %u";
          "lanman auth" = "yes";
          "client lanman auth" = "yes";
          "client plaintext auth" = "yes";
          "ntlm auth" = "yes";
          "bind interfaces only" = "yes";
        };
        storage = {
          path = "${config.homelab.storageDir}";
          writable = "true";
          comment = "NAS Storage share";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "guest account" = "ye";
        };
      };
    };
    avahi = {
      enable = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    samba-wsdd = {
      enable = true;
    };
  };
}
