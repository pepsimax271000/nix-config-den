{ inputs, username, host, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./defaults.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./hugo.nix
    ./jellyfin-tui.nix
    #./ncmpcpp.nix
    ./nix.nix
    ./nvim.nix
    ./ripgrep.nix
    ./yazi.nix
    ./yt.nix
    ./zoxide.nix
  ];
}
