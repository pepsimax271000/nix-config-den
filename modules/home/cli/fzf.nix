{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "rg --hidden --files --iglob '\!dosdevices' --iglob '\!drive_c' --iglob '\!.git'";
  };
}
