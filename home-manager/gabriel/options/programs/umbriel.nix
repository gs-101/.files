{ pkgs, ... }:
{
  imports = [
    ./noctalia.nix
  ];
  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        autostart = [ "noctalia" ];
        xwayland = true;
      };
      include.optional.files = [ "~/.config/umbriel/noctalia.toml" ];
      input = {
        cursor.hide_when_typing = true;
        focus.follows_mouse = true;
        keyboard.options = "ctrl:nocaps";
      };
      layout = {
        extent_presets = [
          0.333
          0.5
          0.667
        ];
        scrolling.default_extent_fraction = 0.5;
      };
      keybinds = {
        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";
        "Mod+Alt+Left" = "column-focus-tab-previous";
        "Mod+Alt+Right" = "column-focus-tab-next";
        "Mod+C" = "spawn:noctalia msg panel-toggle oldirtty/color_picker:panel";
        "Mod+Comma" = "window-consume-left";
        "Mod+Ctrl+F" = {
          action = "window-toggle-maximize";
          repeat = false;
        };
        "Mod+Ctrl+Space" = {
          action = "window-restore-from-scratchpad";
          repeat = false;
        };
        "Mod+Down" = "window-focus-down";
        "Mod+E" = "spawn:$VISUAL";
        "Mod+Escape" = "session-quit";
        "Mod+F" = {
          action = "window-toggle-fullscreen";
          repeat = false;
        };
        "Mod+H" = "window-focus-left";
        "Mod+J" = "window-focus-down";
        "Mod+K" = "window-focus-up";
        "Mod+L" = "window-focus-right";
        "Mod+Left" = "window-focus-left";
        "Mod+M" = {
          action = "window-toggle-maximize-to-edges";
          repeat = false;
        };
        "Mod+O" = {
          action = "overview-toggle";
          repeat = false;
        };
        "Mod+P" = {
          action = "window-toggle-pinned";
          repeat = false;
        };
        "Mod+Period" = "window-consume-right";
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Q" = {
          action = "window-close";
          repeat = false;
        };
        "Mod+Return" = "spawn:$TERM";
        "Mod+Right" = "window-focus-right";
        "Mod+Shift+1" = "window-move-to-workspace:1";
        "Mod+Shift+2" = "window-move-to-workspace:2";
        "Mod+Shift+3" = "window-move-to-workspace:3";
        "Mod+Shift+4" = "window-move-to-workspace:4";
        "Mod+Shift+5" = "window-move-to-workspace:5";
        "Mod+Shift+6" = "window-move-to-workspace:6";
        "Mod+Shift+7" = "window-move-to-workspace:7";
        "Mod+Shift+8" = "window-move-to-workspace:8";
        "Mod+Shift+9" = "window-move-to-workspace:9";
        "Mod+Shift+Escape" = {
          allow_when_inhibited = true;
          action = "shortcuts-inhibit-toggle";
          repeat = false;
        };
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+R" = "window-cycle-primary-extent-back";
        "Mod+Shift+Right" = "column-move-right";
        "Mod+Shift+Space" = {
          action = "window-move-to-scratchpad";
          repeat = false;
        };
        "Mod+Shift+T" = {
          action = "window-focus-switch-floating";
          repeat = false;
        };
        "Mod+Shift+Up" = "window-move-up";
        "Mod+Space" = "scratchpad-toggle";
        "Mod+T" = {
          action = "window-toggle-floating";
          repeat = false;
        };
        "Mod+Tab" = "scratchpad-focus-next";
        "Mod+Up" = "window-focus-up";
        "Mod+V" = "spawn:noctalia msg panel-toggle clipboard";
        "Mod+W" = {
          action = "column-toggle-tabbed";
          repeat = false;
        };
        "Mod+WheelDown" = "window-focus-right";
        "Mod+WheelUp" = "window-focus-left";
        "Mod+X" = "spawn:noctalia msg panel-toggle launcher";
        "Print" = "spawn:noctalia msg screenshot-fullscreen";
        "Shift+Print" = "spawn:noctalia msg screenshot-region";
        "XF86AudioLowerVolume" = {
          action = "spawn:noctalia msg volume-down";
          allow_when_inhibited = true;
        };
        "XF86AudioMicMute" = {
          action = "spawn:noctalia msg mic-mute";
          allow_when_inhibited = true;
        };
        "XF86AudioMute" = {
          action = "spawn:noctalia msg volume-mute";
          allow_when_inhibited = true;
        };
        "XF86AudioNext" = {
          action = "spawn:noctalia msg media next";
          allow_when_inhibited = true;
        };
        "XF86AudioPause" = {
          action = "spawn:noctalia msg media toggle";
          allow_when_inhibited = true;
        };
        "XF86AudioPlay" = {
          action = "spawn:noctalia msg media toggle";
          allow_when_inhibited = true;
        };
        "XF86AudioPrev" = {
          action = "spawn:noctalia msg media previous";
          allow_when_inhibited = true;
        };
        "XF86AudioRaiseVolume" = {
          action = "spawn:noctalia msg volume-up";
          allow_when_inhibited = true;
        };
        "XF86MonBrightnessDown" = {
          action = "spawn:noctalia msg brightness-down";
          allow_when_inhibited = true;
        };
        "XF86MonBrightnessUp" = {
          action = "spawn:noctalia msg brightness-up";
          allow_when_inhibited = true;
        };
      };
      layer_rule = [
        {
          blur = true;
          blur_ignore_alpha = 0.5;
          blur_optimized = false;
          match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
        }
      ];
      window_rule = [
        {
          blur = true;
          blur_optimized = true;
        }
        {
          default_floating = true;
          default_floating_size_px = {
            height = 900;
            width = 1020;
          };
          match.app_id = "^dev.noctalia.Noctalia$";
        }
      ];
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-umbriel
      pkgs.xdg-desktop-portal-gtk
    ];
    config.umbriel.default = [
      "umbriel"
      "gtk"
    ];
  };
}
