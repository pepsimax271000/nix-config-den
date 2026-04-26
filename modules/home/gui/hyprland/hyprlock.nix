{ config,
  inputs,
  pkgs,
  ... 
}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        disable_loading_bar = true;
      };

#      background = [
#        {
#          path = ./../../../wallpapers/jellyfish.jpg;
#          blur_passes = 2;
#          contrast = 1;
#          brightness = 0.5;
#          vibrancy = 0.2;
#          vibrancy_darkness = 0.2;
#        }
#      ];
#
#      input-field = [
#        {
#          monitor = "";
#          size = "250, 60";
#          outline_thickness = 2;
#          dots_size = 0.2;
#          dots_spacing = 0.35;
#          dots_center = true;
#          fade_on_empty = false;
#          rounding = -1;
#          font_color = "rgb(cdd6f4)";
#          placeholder_text = "Password...";
#          hide_input = false;
#          position = "0, -200";
#          halign = "center";
#          valign = "center";
#        }
#      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +'%-I:%M%p'";
          font_size = 95;
          font_family = "Caskaydia Cove Nerd Font";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] date +'%A, %B %d'";
          font_size = 22;
          font_family = "Caskaydia Cove Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
     };
    };
 }
