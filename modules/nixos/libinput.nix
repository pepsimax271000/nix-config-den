{ config, pkgs, ... }:
{
 environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
    [Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
 '';
}
