{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      btop
      eza
      fd
      jq
      ripgrep
    ];
  };

  flake.homeModules.shell = { pkgs, ... }: {
    programs = {
      bat.enable = true;
       
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

      btop = {
        enable = true;
	settings = {
	  theme_background = false;
	  rounded_corners = false;
        };
      };

      fzf = {
        enable = true;
	enableFishIntegration = true;
      };

      yazi = {
        enable = true;
	enableFishIntegration = true;
	shellWrapperName = "y";

	settings = {
	  manager = {
	    linemode = "size";
	    show_symlink = true;
	    sort_by = "natural";
	    sort_dir_first = true;
	    sort_reverse = false;
	    sort_sensitive = false;
	  };
        };
      };

      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
          function fish_user_key_bindings
            fish_vi_key_bindings
          end
          function fish_mode_prompt
          end
          function y
          	set tmp (mktemp -t "yazi-cwd.XXXXXX")
          	yazi $argv --cwd-file="$tmp"
          	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          		builtin cd -- "$cwd"
          	end
          	rm -f -- "$tmp"
          end
        '';

        shellAbbrs = {
          "vim" = "nvim";
          "vi" = "nvim";
          "v" = "nvim";
          "neovim" = "nvim";
          "n" = "nvim";
          "vfzf" = "nvim $(fzf)";
          "cp" = "cp -iv";
          "mv" = "mv -iv";
          "rm" = "rm -vI";
          "rsync" = "rsync -vrPlu";
          "md" = "mkdir -pv";
          "fa" = "fastfetch --config examples/13.jsonc";
          
          "g" = "git";
          "gc" = "git clone";
          "ga" = "git add";
          "gaa" = "git add -A";
          "gcm" = "git commit -m";
          "gp" = "git push";
          "gpp" = "git pull";
          
          "yt" = "yt-dlp --embed-metadata -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'";
          "yta" = "yt -x -f bestaudio/best";
          "ffmpeg" = "ffmpeg -hide_banner";
          
          "ls" = "eza --group-directories-first --icons always";
          "ll" = "eza --group-directories-first -lag --icons always --header";
          "grep" = "rg";
          "cat" = "bat";
          "cd" = "z";
          "cc" = "clear; z";
          "ka" = "killall";
          
          ".." = "z ..";
          "..." = "z ../..";
          "...." = "z ../../..";

          "untar" = "tar -zxvf";
          "mktar" = "tar -cvzf";

          # Nixos related
          "nr" = "nixos-rebuild";
          "nuc" = "nh os switch ~/nix-config -u && nh clean all";
          "nru" = "z ~/nix-config && doas nixos-rebuild switch --flake . --upgrade";
          "nsp" = "nix-shell -p";
          "scg" = "doas nix-collect-garbage -d";
          "ucg" = "nix-collect-garbage -d";
          "cfg" = "z /home/ye/nix-config/";
          "rn" = "nh os switch ~/nix-config";
        };
      };
    };
  };
}
