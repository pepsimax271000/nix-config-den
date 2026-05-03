{ ... }: {
  flake.nixosModules.dns = { config, ... }: {
    services.caddy.virtualHosts."adguard.${config.homelab.domain}".extraConfig = ''
      reverse_proxy "localhost:3000"
    '';

    networking.firewall = {
      allowedUDPPorts = [ 5335 53 ];
      allowedTCPPorts = [ 5335 53 ];
    };

    services = {
      adguardhome = {
        enable = true;
        openFirewall = true;
        port = 3000;
        settings = {
          dns = {
            upstream_dns = [
	          "https://dns.quad9.net/dns-query"
              "tls://dns.quad9.net"
            ];
            bootstrap_dns = [
              "9.9.9.9"
              "149.112.112.10"
              "2620:fe::10"
              "2620:fe::fe:10"
            ];
	          upstream_mode = "parallel";
            local_domain_name = "${config.homelab.domain}";
            cache_enabled = true;
            cache_ttl_min = 3600;
            cache_ttl_max = 86400;
            enable_dnssec = true;
            ratelimit = 0;
          };

          filters = [
            {
              enabled = true;
              url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
              name = "AdGuard DNS filter";
              id = 1;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
              name = "AdAway Default Blocklist";
              id = 2;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_64.txt"; 
              name = "1Hosts (Pro)";
              id = 3;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_59.txt"; 
              name = "AdGuard DNS Popup Hosts filter";
              id = 4;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_53.txt"; 
              name = "AWAvenue ads rule";
              id = 5;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_4.txt"; 
              name = "Dan Pollock's List";
              id = 6;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_51.txt"; 
              name = "HaGeZi's Pro++ Blocklist";
              id = 7;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt"; 
              name = "Steven Black's list";
              id = 8;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt"; 
              name = "OISD Blocklist Big";
              id = 9;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt"; 
              name = "Peter Lowe's Blocklist";
              id = 10;
            }
          ];
        };
      };
    };
  };
}
