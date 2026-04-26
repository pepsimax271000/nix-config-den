{ lib, config, pkgs, ... }:
{
  programs.git = {
    settings = {
      user.name = "pepsimax271000";
      user.email = "248238336+pepsimax271000@users.noreply.github.com";
      init.defaultBranch = "master";
    };
    enable = true;
  };

  home.packages = [ pkgs.gh ];
}
