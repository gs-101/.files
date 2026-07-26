{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    evtest
    gpu-screen-recorder
    kdePackages.qttools
    wtype
  ];
  programs.noctalia = {
    enable = true;
    settings = {
      audio = {
        enable_overdrive = true;
        enable_sounds = true;
      };
      bar = {
        widgets = {
          auto_hide = true;
          border = "primary";
          border_width = 1.0;
          center = [ "clock" ];
          concave_edge_corners = false;
          end = [
            "recorder"
            "notifications"
            "clipboard"
            "volume"
            "brightness"
            "battery"
            "cat"
            "control-center"
          ];
          layer = "overlay";
          margin_edge = 5;
          margin_ends = 5;
          radius = 24;
          reserve_space = false;
          shadow = false;
          start = [
            "workspaces"
            "media"
          ];
        };
      };
      control_center = {
        shortcuts = [
          {
            type = "wifi";
          }
          {
            type = "bluetooth";
          }
          {
            type = "caffeine";
          }
          {
            type = "notification";
          }
        ];
      };
      desktop_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [ ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
      };
      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];
        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600.0;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = true;
            timeout = 900.0;
          };
          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 660.0;
          };
        };
      };
      location = {
        auto_locate = true;
      };
      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
      };
      notification = {
        background_opacity = 1.0;
        layer = "overlay";
      };
      osd = {
        background_opacity = 1.0;
      };
      plugin_settings = {
        "nightwatch75/file-search" = {
          panel_open_near_click = false;
          panel_position = "center";
        };
        "noctalia/screen_recorder" = {
          copy_to_clipboard = true;
          directory = "~/Videos/recordings";
          hide_inactive = false;
          quality = "ultra";
        };
        "oldirtty/color_picker" = {
          hyprpicker-lowercase = true;
          panel_placement = "attached";
          swatch-radius = 24;
        };
        "yocraft/web-launcher" = {
          icon_provider = "direct";
        };
      };
      plugins = {
        enabled = [
          "noctalia/bongocat"
          "noctalia/screen_recorder"
          "noctalia/kaomoji"
          "oldirtty/color_picker"
          "nightwatch75/file-search"
        ];
      };
      shell = {
        avatar_path = "~/.face";
        niri_overview_type_to_launch_enabled = true;
        password_style = "random";
        polkit_agent = true;
        screen_time_enabled = true;
        settings_show_advanced = true;
        show_location = false;
        telemetry_enabled = true;
        panel = {
          clipboard_placement = "attached";
          control_center_placement = "centered";
          launcher_app_grid = true;
          launcher_compact = true;
          session_position = "center";
          shadow = false;
          wallpaper_placement = "centered";
        };
        screenshot = {
          directory = "~/Pictures/screenshots";
        };
        session = {
          actions = [
            {
              action = "lock";
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = "1";
              variant = "default";
            }
            {
              action = "shutdown";
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = "2";
              variant = "destructive";
            }
            {
              action = "reboot";
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = "3";
              variant = "default";
            }
            {
              action = "logout";
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = "4";
              variant = "default";
            }
          ];
        };
        shadow = {
          alpha = 0.0;
        };
      };
      theme = {
        mode = "auto";
        pure_black_dark = true;
        source = "wallpaper";
        wallpaper_scheme = "m3-content";
        templates = {
          builtin_ids = [
            "alacritty"
            "btop"
            "cava"
            "emacs"
            "foot"
            "gtk3"
            "gtk4"
            "ghostty"
            "helix"
            "hyprland"
            "kcolorscheme"
            "kitty"
            "labwc"
            "mango"
            "niri"
            "qt"
            "scroll"
            "sway"
            "wezterm"
          ];
          community_ids = [
            "feishin"
            "pear-desktop"
            "spicetify"
            "tauon"
            "pywalfox"
            "pywalfox-beta4"
            "zen-browser"
            "neovim"
            "obsidian"
            "vscode"
            "zed"
            "fuzzel"
            "rofi"
            "velo"
            "vicinae"
            "walker"
            "antigravity"
            "bat"
            "discord"
            "heroiclauncher"
            "lazygit"
            "nchat"
            "obs"
            "opencode"
            "papirus-icons"
            "pi-agent"
            "prismlauncher"
            "steam"
            "telegram"
            "yazi"
            "zathura"
            "hyprtoolkit"
            "snappy-switcher"
          ];
        };
      };
      wallpaper = {
        automation = {
          enabled = true;
        };
      };
      widget = {
        battery = {
          display_mode = "graphic";
        };
        cat = {
          audio_spectrum = true;
          input_devices = [
            "/dev/input/by-id/usb-275d_USB_OPTICAL_MOUSE-event-mouse"
            "/dev/input/by-id/usb-2a7a_CASUE_USB_KB-event-kbd"
          ];
          tappy_mode = true;
          type = "noctalia/bongocat:cat";
        };
        media = {
          hide_when_no_media = true;
          title_scroll = "always";
        };
        notifications = {
          hide_when_no_unread = true;
        };
        recorder = {
          type = "noctalia/screen_recorder:recorder";
        };
        volume = {
          actions = {
            scroll_down = "volume-down 1%";
            scroll_up = "volume-up 1%";
          };
        };
        workspaces = {
          hide_when_empty = true;
          labels_only_when_occupied = true;
          minimal = true;
          style = "minimal";
        };
      };
    };
  };
}
