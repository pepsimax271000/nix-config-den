{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/media/NAS/media/Music/downloads/";
    dataDir = "/media/NAS/media/Music/mpd";
  };
  programs = {
    ncmpcpp = {
      enable = true;
      mpdMusicDir = "/media/NAS/media/Music/downloads/";
      bindings = [
        { key = "+"; command = "show_clock"; }
        { key = "="; command = "volume_up"; }
        
        { key = "j"; command = "scroll_down"; }
        { key = "k"; command = "scroll_up"; }
        
        { key = "ctrl-u"; command = "page_up"; }
        #push_characters "kkkkkkkkkkkkkkk"
        { key = "ctrl-d"; command = "page_down"; }
        #push_characters "jjjjjjjjjjjjjjj"
        { key = "u"; command = "page_up"; }
        #push_characters "kkkkkkkkkkkkkkk"
        { key = "d"; command = "page_down"; }
        #push_characters "jjjjjjjjjjjjjjj"
        { key = "h"; command = "previous_column"; }
        { key = "l"; command = "next_column"; }
        
        { key = "."; command = "show_lyrics"; }
        
        { key = "n"; command = "next_found_item"; }
        { key = "N"; command = "previous_found_item"; }
        
        { key = "J"; command = "move_sort_order_down"; }
        { key = "K"; command = "move_sort_order_up"; }
        { key = "h"; command = "jump_to_parent_directory"; }
        { key = "l"; command = "enter_directory"; }
        { key = "l"; command = "run_action"; }
        { key = "l"; command = "play_item"; }
        { key = "m"; command = "show_media_library"; }
        { key = "m"; command = "toggle_media_library_columns_mode"; }
        { key = "t"; command = "show_tag_editor"; }
        { key = "v"; command = "show_visualizer"; }
        { key = "G"; command = "move_end"; }
        { key = "g"; command = "move_home"; }
        #jump_to_position_in_= ong
        { key = "U"; command = "update_database"; }
        { key = "s"; command = "reset_search_engine"; }
        { key = "s"; command = "show_search_engine"; }
        { key = "f"; command = "show_browser"; }
        { key = "f"; command = "change_browse_mode"; }
        { key = "x"; command = "delete_playlist_items"; }
        { key = "P"; command = "show_playlist"; }
      ];
    };
  };
}
