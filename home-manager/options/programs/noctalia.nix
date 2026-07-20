{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      evtest
      gpu-screen-recorder
      kdePackages.qttools
      wtype
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
          border_width = 1.0;
          center = [ "clock" ];
          end = [
            "recorder"
            "notifications"
            "volume"
            "brightness"
            "battery"
            "control-center"
          ];
          layer = "overlay";
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
        "noctalia/screen_recorder" = {
          copy_to_clipboard = true;
          directory = "~/Videos/recordings";
          hide_inactive = true;
          quality = "ultra";
        };
      };
      plugins = {
        enabled = [
          "avivbintangaringga/nix-monitor"
          "nightwatch75/file-search"
          "noctalia/bongocat"
          "noctalia/screen_recorder"
          "radimous/prism-launcher-instances"
          "yocraft/web-launcher"
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
          control_center_placement = "centered";
          launcher_app_grid = true;
          launcher_compact = true;
          session_placement = "centered";
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
          scroll_step = 1;
        };
        workspaces = {
          labels_only_when_occupied = true;
          minimal = true;
        };
      };
    };
  };
}
