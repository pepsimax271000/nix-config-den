{ pkgs, ... }: {
  flake.nixosModules.neovim = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraPackages = with pkgs; [
        lua-language-server
	nixd
	tpescript-language-server
	ripgrep
	fd
      ];
      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
    };
  };
}
