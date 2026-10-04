{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      evtest
      gpu-screen-recorder
      hyprpicker
    ];
  };
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
          border_width = 1;
          center = [
            "clock"
          ];
          concave_edge_corners = false;
          end = [
            "recorder"
            "notifications"
            "bar"
            "clipboard"
            "volume"
            "brightness"
            "battery"
            "cat"
          ];
          layer = "overlay";
          margin_edge = 5;
          margin_ends = 5;
          radius = 24;
          reserve_space = false;
          shadow = true;
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
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
        };
        widget_order = [
        ];
      };
      idle = {
        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = true;
            timeout = 900;
          };
          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };
        };
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];
      };
      location = {
        auto_locate = true;
      };
      lockscreen_widgets = {
        enabled = true;
        grid = {
          cell_size = 8;
          major_interval = 4;
          visible = true;
        };
        schema_version = 2;
        widget = {
          "lockscreen-login-box@eDP-1" = {
            box_height = 196;
            box_width = 720;
            cx = 683;
            cy = 649;
            output = "eDP-1";
            placement_height = 768;
            placement_width = 1366;
            rotation = 0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12;
              center_password_text = false;
              input_opacity = 1;
              input_radius = 6;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
            type = "login_box";
          };
          "lockscreen-widget-0000000000000001" = {
            box_height = 328;
            box_width = 376;
            cx = 683.75;
            cy = 256.75;
            output = "eDP-1";
            placement_height = 768;
            placement_width = 1366;
            rotation = 0;
            settings = {
              background = false;
              background_color = "surface";
              background_opacity = 0.8;
              background_padding = 10;
              background_radius = 12;
              center_text = true;
              circle = false;
              clock_style = "analog";
              color = "surface";
              font_family = "";
              format = "{:%H:%M}";
              shadow = true;
              timezone = "";
            };
            type = "clock";
          };
        };
        widget_order = [
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000001"
        ];
      };
      notification = {
        background_opacity = 1;
        layer = "overlay";
      };
      osd = {
        background_opacity = 1;
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
          "cleboost/ssh-launcher"
          "icefish/phone-connect"
        ];
      };
      shell = {
        avatar_path = "~/.face";
        launcher = {
          categories = false;
          compact = true;
          show_app_origin_indicator = false;
        };
        niri_overview_type_to_launch_enabled = true;
        panel = {
          clipboard_placement = "attached";
          control_center_placement = "centered";
          launcher_app_grid = true;
          launcher_compact = true;
          session_position = "center";
          shadow = true;
          wallpaper_placement = "centered";
        };
        password_style = "random";
        polkit_agent = true;
        readline_shortcuts = true;
        screen_time_enabled = true;
        screenshot = {
          annotate = true;
          directory = "~/Pictures/screenshots";
        };
        session = {
          actions = [
            {
              action = "lock";
              countdown_seconds = 0;
              enabled = true;
              shortcut = "1";
              variant = "default";
            }
            {
              action = "shutdown";
              countdown_seconds = 0;
              enabled = true;
              shortcut = "2";
              variant = "destructive";
            }
            {
              action = "reboot";
              countdown_seconds = 0;
              enabled = true;
              shortcut = "3";
              variant = "default";
            }
            {
              action = "logout";
              countdown_seconds = 0;
              enabled = true;
              shortcut = "4";
              variant = "default";
            }
          ];
        };
        settings_show_advanced = true;
        shadow = {
          alpha = 0;
        };
        show_location = false;
        telemetry_enabled = true;
      };
      theme = {
        mode = "auto";
        pure_black_dark = true;
        source = "wallpaper";
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
            "umbriel"
            "wezterm"
          ];
          community_ids = [
            "antigravity"
            "claude-code"
            "codex"
            "opencode"
            "pi-agent"
            "feishin"
            "pear-desktop"
            "sidra"
            "sone"
            "sonora"
            "spicetify"
            "spotifast"
            "supersonic"
            "tauon"
            "ytm-player"
            "brave"
            "brave-origin"
            "pywalfox"
            "pywalfox-beta4"
            "qutebrowser"
            "ungoogled-chromium"
            "zen-browser"
            "discord"
            "halloy"
            "karere"
            "nchat"
            "senpai"
            "telegram"
            "driftwm"
            "jay"
            "blender"
            "darktable"
            "gimp"
            "inkscape"
            "libreoffice"
            "micro"
            "musescore"
            "neovim"
            "obsidian"
            "vscode"
            "zed"
            "archetype-pokemmo"
            "heroiclauncher"
            "prismlauncher"
            "steam"
            "fuzzel"
            "rofi"
            "velo"
            "vicinae"
            "walker"
            "yeet"
            "fastfetch"
            "mailspring"
            "obs"
            "sioyek"
            "siyuan"
            "thunderbird"
            "zathura"
            "zellij"
            "fcitx5"
            "hyprtoolkit"
            "papirus-icons"
            "snappy-switcher"
            "whitesur-icons"
            "bat"
            "fzf"
            "glow"
            "herdr"
            "konsole"
            "lazygit"
            "rio"
            "superfile"
            "surgedm"
            "tmux"
            "yazi"
          ];
        };
        wallpaper_scheme = "m3-content";
      };
      wallpaper = {
        automation = {
          enabled = true;
        };
        directory = "~/Pictures/wallpapers";
      };
      widget = {
        bar = {
          type = "icefish/phone-connect:bar";
        };
        battery = {
          display_mode = "graphic";
        };
        cat = {
          audio_spectrum = true;
          input_devices = [
            "/dev/input/by-id/usb-275d_USB_OPTICAL_MOUSE-event-mouse"
            "/dev/input/by-id/usb-2a7a_CASUE_USB_KB-event-kbd"
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
            "/dev/input/by-path/platform-AMDI0010:00-event-mouse"
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
          show_labels = false;
          style = "regular";
        };
      };
    };
  };
}
