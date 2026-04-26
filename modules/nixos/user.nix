
{ config, pkgs, inputs, username, host, ... }:

let
  # Define Home Manager imports per host
  homeImports = {
    aperture = [ ./../home/cli ];
    chell    = [ ./../home/cli ];
    testvm   = [ ./../home/cli ];
    glados   = [ ./../home/cli ];
    proxvm   = [ ./../home/cli ];

    # Fallback when host is not explicitly defined
    default  = [ inputs.self.homeModules.default ];
  };

  # Select imports for the current host, falling back to default
  selectedHomeImports = homeImports.${host} or homeImports.default;

  # Common SSH key
  defaultSSHKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWKYIrwL21t4Q/hbGUmLuVFOb1b77OHjbL0vqSo13kc ye@atlas";

in {
  imports = [
    # Core NixOS modules
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops

    # Share sops-nix with Home Manager
    {
      home-manager.sharedModules = 
      [ inputs.sops-nix.homeManagerModules.sops 
        inputs.noctalia.homeModules.default
      ];
    }
  ];

  # --- Home Manager configuration ---
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs username host;
      inherit (inputs) self;
    };

    users.${username} = {
      imports = selectedHomeImports;

      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "24.11";
      };

      programs.home-manager.enable = true;
    };
  };

  sops.secrets = {
    user_password.neededForUsers = true;
    root_password.neededForUsers = true;
  };

  users.mutableUsers = false;

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = username;
      shell = pkgs.fish;
      hashedPasswordFile = config.sops.secrets.user_password.path;
      extraGroups = [ "networkmanager" "wheel" "adbusers" "kvm" "input" "dialout" "uucp" ];
      openssh.authorizedKeys.keys = [ defaultSSHKey ];
    };

    root = {
      hashedPasswordFile = config.sops.secrets.root_password.path;
      openssh.authorizedKeys.keys = [ defaultSSHKey ];
    };
  };
}
