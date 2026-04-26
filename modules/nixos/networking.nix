{ lib, config, pkgs, host, ... }:
{
  boot.kernelParams = ["ipv6.disable=1"];
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = false;
    };
  };
  networking = {
    enableIPv6 = false;
    firewall = {
      enable = false;
    };  
    hostName = "${host}";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      dns = "systemd-resolved";
    };
  };
}
