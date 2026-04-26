{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       env = [
          "GDK_BACKEND,wayland"
          "HYPRCUROR_SIZE,24"
          "HYPRCURSOR_THEME,Bibata Modern Classic"
          "MOZ_ENABLE_WAYLAND,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_QPA_PlATFORM,wayland"
          "QT_STYLE_OVERRIDE,kvantum"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "SDL_VIDEODRIVER,wayland"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
       ];
     };
  };
}
