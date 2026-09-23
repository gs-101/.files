{
  imports = [
    ./noctalia.nix
  ];
  wayland.windowManager.driftwm = {
    enable = true;
    settings = {
      autostart = [ "noctalia" ];
      background = {
        path = "~/Pictures/wallpapers/gigapixel/minecraft/wallpaper-1.tiff";
        type = "tile";
      };
      decorations.default_mode = "none";
      focus_follows_mouse = true;
      input = {
        keyboard = {
          layout = "br";
          options = "ctrl:nocaps";
        };
        trackpad = {
          disable_on_external_mouse = true;
          natural_scroll = false;
        };
      };
      keybindings = {
        "mod+e" = "spawn $VISUAL";
        "mod+escape" = "quit";
        "mod+period" = "spawn noctalia msg panel-toggle launcher /emo";
        "mod+v" = "spawn noctalia msg panel-toggle clipboard";
        "Print" = "spawn noctalia msg screenshot-fullscreen";
        "shift+Print" = "spawn noctalia msg screenshot-region";
        "XF86AudioLowerVolume" = "spawn noctalia msg volume-down";
        "XF86AudioMicMute" = "spawn noctalia msg mic-mute";
        "XF86AudioMute" = "spawn noctalia msg volume-mute";
        "XF86AudioNext" = "spawn noctalia msg media next";
        "XF86AudioPause" = "spawn noctalia msg media toggle";
        "XF86AudioPlay" = "spawn noctalia msg media toggle";
        "XF86AudioPrev" = "spawn noctalia msg media previous";
        "XF86AudioRaiseVolume" = "spawn noctalia msg volume-up";
        "XF86MonBrightnessDown" = "spawn noctalia msg brightness-down";
        "XF86MonBrightnessUp" = "spawn noctalia msg brightness-up";
      };
      session = {
        restore_bookmarks = true;
        restore_camera = true;
        restore_windows = true;
      };
    };
  };
}
