{ self, inputs, ...}: {
  flake.homeModules.neovim = { config, pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraPackages = with pkgs; [
        lua-language-server
	      nixd
	      typescript-language-server
	      ripgrep
	      fd
      ];
      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
    };
  };
}
