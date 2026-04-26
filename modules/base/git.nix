{ self, inputs, ... }: {
  flake.nixosModules.git = { pkgs, lib, ... }: {
    programs.git = {
      enable = true;
      config = {
        user.name = "pepsimax271000";
        user.email = "248238336+pepsimax271000@users.noreply.github.com";
        init.defaultBranch = "master";
        core.editor = "nvim";
        pull.rebase = true;
      };
    };
  };
}
