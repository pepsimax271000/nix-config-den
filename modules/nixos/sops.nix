{ config, pkgs, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.networking) hostName;
  inherit (config.users.users) ye;
  
  # Define secret file paths for better maintainability
  secretPaths = {
    common = ./../../secrets/secrets.yaml;
    homelab = ./../../secrets/homelab.yaml;
  };

  # Common configuration for YAML secrets
  yamlSecret = sopsFile: {
    format = "yaml";
    inherit sopsFile;
  };

  # Helper for homelab secrets with custom attributes
  homelabSecret = attrs: yamlSecret secretPaths.homelab // attrs;

  # Predicate for homelab hosts
  isHomelabHost = hostName == "glados" || hostName == "chell";

  # Common secrets used across all hosts
  commonSecrets = {
    email = {};
    user_password = {};
    root_password = {};
    github_token = {};
    GH_TOKEN_FOR_UPDATES = {};
    ssh_key = {};
  };

  # Homelab-specific secrets (conditionally included)
  homelabSecrets = mkIf isHomelabHost {
    deluge = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
      mode = "0775";
      owner = config.users.users.share.name;
      group = config.users.users.share.group;
    };

    qbittorrent_password = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
      mode = "0775";
      owner = config.users.users.share.name;
      group = config.users.users.share.group;
    };
    # Database and service passwords
    db_password = yamlSecret secretPaths.homelab;
    paperless_password = yamlSecret secretPaths.homelab;
    
    # Service-specific secrets
    searx-secret = yamlSecret secretPaths.homelab;
    imadam-email = yamlSecret secretPaths.homelab;
    slskd = yamlSecret secretPaths.homelab;
    jellyfin-homepage-api = yamlSecret secretPaths.homelab;
    jellyseerr-homepage-api = yamlSecret secretPaths.homelab;
    radarr-homepage-api = yamlSecret secretPaths.homelab;
    sonarr-homepage-api = yamlSecret secretPaths.homelab;
    prowlarr-homepage-api = yamlSecret secretPaths.homelab;
    slskd-homepage-api = yamlSecret secretPaths.homelab;
    immich-homepage-api = yamlSecret secretPaths.homelab;
    cloudflare_api_token = yamlSecret secretPaths.homelab;
  };

  allSecrets = commonSecrets // homelabSecrets;

in
{
  sops = {
    # Default configuration
    defaultSopsFile = secretPaths.common;
    defaultSopsFormat = "yaml";
    age.keyFile = "/keys.txt";
    
    # Validate that required secrets exist for homelab hosts
    validateSopsFiles = mkIf isHomelabHost true;
    
    # All secret definitions
    secrets = allSecrets;
  };
}
#{ config, pkgs, lib, ... }:
#
#let
#  hostname = config.networking.hostName;
#  commonSecrets = {
#    email = {};
#    user_password = {};
#    root_password = {};
#    github_token = {};
#    ssh_key = {};
#  };
#
#  homelabSecrets = lib.mkIf (hostname == "glados" || hostname == "proxvm") {
#    db_password = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    searx-secret = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    paperless_password = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    deluge = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#      mode = "0775";
#      owner = config.users.users.share.name;
#      group = config.users.users.share.group;
#    };
#    cloudflare_api_token = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    imadam-email = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    slskd = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    pyload = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#  };
#
#  cloudflareSecrets = {
#    fagwar-api-key = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#    adam-aperture-tunnel-id = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#    adam-aperture-tunnel = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#    fagwar-email = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#  };
#in
#{
#  sops = {
#    defaultSopsFile = ./../../secrets/secrets.yaml;
#    defaultSopsFormat = "yaml";
#    age.keyFile = "/keys.txt";
#    secrets = commonSecrets // homelabSecrets // cloudflareSecrets;
#  };
#}
