{ config, pkgs, ... }:

{
  # Enable Unbound DNS resolver
  services.unbound = {
    enable = true;

    # Define Unbound settings
    settings = {
      server = {
        # Bind to a non-default port (default is 53)
        port = 5335;

        # Enable caching
        cache-max-ttl = 86400;  # Maximum TTL for cache (1 day)
        cache-min-ttl = 3600;   # Minimum TTL for cache (1 hour)
        harden-dnssec-stripped = "yes";  # Enforce DNSSEC validation
        do-ip4 = "yes";         # Enable IPv4
        do-ip6 = "no";         # Enable IPv6 (disable if not needed)
        do-udp = "yes";         # Enable UDP
        do-tcp = "yes";         # Enable TCP
        harden-referral-path = "yes";  # Additional security for referrals
        prefetch = "yes";       # Prefetch DNS records before they expire
        prefetch-key = "yes";   # Prefetch DNSKEYs for faster validation
        num-threads = 2;
        rrset-cache-size = "256m";
        msg-cache-size = "128m";
        so-rcvbuf = "1m";

        # Interface to listen on (0.0.0.0 for all interfaces)
        interface = [ "0.0.0.0" "::0" ];

        # Access control (adjust based on your network)
        access-control = [
          "0.0.0.0/0 allow"    # Allow all IPv4 clients
          "::0/0 allow"        # Allow all IPv6 clients
        ];

        # Define private domain for tjd.lol
        private-domain = [ "tjd.lol" ];
      };

      # Forward upstream DNS servers for non-local queries
    };
  };
  services.adguardhome = {
    enable = true;
    openFirewall = true;  # Automatically open firewall ports
    port = 3000;  # Use default DNS port (53) for AdGuard Home
    host = "0.0.0.0";  # Listen on all interfaces
    settings = {
      # General settings
      http = {
        address = "0.0.0.0:3000";  # Web interface accessible on all interfaces
      };

      # DNS settings
      dns = {
        bind_hosts = [ "0.0.0.0" "::0" ];  # Listen on all IPv4 and IPv6 interfaces
        port = 53;  # DNS port
        upstream_dns = [
          "[/tjd.lol/]127.0.0.1:5335"  # Forward DNS queries to Unbound on port 5353
        ];
        # Bootstrap DNS for resolving upstream servers (if needed)
        bootstrap_dns = [
          "9.9.9.9"
          "149.112.112.10"
          "2620:fe::10"
          "2620:fe::fe:10"
        ];
        # Allow local domain resolution for tjd.lol
        local_domain_name = "tjd.lol";
        use_private_ptr_resolvers = true;  # Resolve private domains locally
        local_ptr_upstreams = [
          "127.0.0.1:5335"  # Use Unbound for reverse DNS (PTR) lookups
        ];
        # Enable DNS caching in AdGuard Home
        cache_enabled = true;
        cache_ttl_min = 3600;  # Minimum TTL (1 hour)
        cache_ttl_max = 86400; # Maximum TTL (1 day)
        # DNS security settings
        enable_dnssec = true;  # Enable DNSSEC (Unbound handles validation)
        ratelimit = 20;  # Queries per second per client
      };

      # Filtering settings (example)
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
      filtering_enabled = true;
      safebrowsing_enabled = false;
      parental_enabled = false;  # Enable if you want parental controls
    };
  };

  # Open firewall for the custom port
  networking.firewall = {
    allowedUDPPorts = [ 5335 ];
    allowedTCPPorts = [ 5335 ];
  };
}
