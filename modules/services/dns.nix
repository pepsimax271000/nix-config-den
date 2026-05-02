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
      unbound = {
        enable = true;
        settings = {
          server = {
            port = 5335;
            cache-max-ttl = 86400;
            cache-min-ttl = 3600;
            harden-dnssec-stripped = "yes";
            do-ip4 = "yes";
            do-ip6 = "no";
            do-udp = "yes";
            do-tcp = "yes";
            harden-referral-path = "yes";
            prefetch = "yes";
            prefetch-key = "yes";
            num-threads = 2;
            rrset-cache-size = "256m";
            msg-cache-size = "128m";
            so-rcvbuf = "1m";

            interface = [ "0.0.0.0" "::0" ];

            access-control = [
              "0.0.0.0/0 allow"
              "::0/0 allow"
            ];

            private-domain = [ "${config.homelab.domain}" ];
          };
        };
      };
      adguardhome = {
        enable = true;
        openFirewall = true;
        port = 3000;
        host = "0.0.0.0";
        settings = {
          http = {
            address = "0.0.0.0:3000";
          };
          dns = {
            bind_hosts = [ "0.0.0.0" "::0" ];
            port = 53;
            upstream_dns = [
              "[/${config.homelab.domain}/]127.0.0.1:5335"
            ];
            bootstrap_dns = [
              "9.9.9.9"
              "149.112.112.10"
              "2620:fe::10"
              "2620:fe::fe:10"
            ];
            local_domain_name = "${config.homelab.domain}";
            use_private_ptr_resolvers = true;
            local_ptr_upstreams = [
              "127.0.0.1:5335"
            ];
            cache_enabled = true;
            cache_ttl_min = 3600;
            cache_ttl_max = 86400;
            enable_dnssec = true;
            ratelimit = 20;
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
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_39.txt"; 
              name = "Dandelion Sprout's Anti Push Notifications";
              id = 8;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt"; 
              name = "Steven Black's list";
              id = 9;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt"; 
              name = "OISD Blocklist Big";
              id = 10;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt"; 
              name = "Peter Lowe's Blocklist";
              id = 11;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_6.txt"; 
              name = "Dandelion Sprout's Game Console Adblock List";
              id = 12;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt"; 
              name = "Perflyst and Dandelion Sprout's Smart-TV Blocklist";
              id = 13;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_47.txt"; 
              name = "HaGeZi's Gambling Blocklist";
              id = 14;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_60.txt"; 
              name = "HaGeZi's Xiaomi Tracker Blocklist";
              id = 15;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_61.txt"; 
              name = "HaGeZi's Samsung Tracker Blocklist";
              id = 16;
            }
            {
              enabled = true;
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_63.txt"; 
              name = "HaGeZi's Windows/Office Tracker Blocklist";
              id = 17;
            }
          ];
        };
      };

    };
  };
}
