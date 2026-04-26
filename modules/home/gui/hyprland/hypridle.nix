{ pkgs, config, ... }:
{
  services.hypridle = {
    enable = true;
    
    settings = {
      general = {
        lock_cmd = "pidof noctalia || noctalia-shell ipc call lockScreen lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
      {
        timeout = 300;
        on-timeout = "brightnessctl -s set 10";
        on-resume = "brightnessctl -r";
      }
      {
        timeout = 900;
        on-timeout = "loginctl lock-session";
      }
      {
        timeout = 1500;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
      {
        timeout = 2700;
        on-timeout = "systemctl suspend";
      }
    ];
  };
 };
}

