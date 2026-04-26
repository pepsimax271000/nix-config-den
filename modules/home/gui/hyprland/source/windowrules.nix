{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "match:title Open File.*, float 1"
        "match:title Select a File.*, float 1"
        "match:title Choose wallpaper.*, float 1"
        "match:title Open Folder.*, float 1"
        "match:title Save As.*, float 1"
        "match:title Library.*, float 1"
        "match:title File Upload.*, float 1"

        # MPV Floating
        "match:class mpv.*, float 1"
      ];
    };
  };
}
