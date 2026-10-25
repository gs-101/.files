{
  config,
  lib,
  pkgs,
  ...
}:
{
  gtk.gtk3.theme = {
    name = "adw-gtk3";
    package = pkgs.adw-gtk3;
  };
  home = {
    packages = with pkgs; [
      evtest
      gpu-screen-recorder
      hyprpicker
    ];
  };
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    qt5ctSettings.Appearance = {
      color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
      custom_palette = true;
    };
    qt6ctSettings.Appearance = {
      color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
      custom_palette = true;
    };
    style = {
      name = "qt6ct-style";
      package = pkgs.qt6Packages.qt6ct;
    };
  };
  programs = {
    bash.initExtra = lib.mkIf config.programs.fzf.enable "source ~/.config/fzf/themes/noctalia.sh";
    bat.config.theme = "noctalia";
    claude-code.settings.theme = "noctalia";
    fuzzel.settings.main.include = "~/.config/fuzzel/themes/noctalia";
    halloy.settings.theme = "noctalia";
    kitty.extraConfig = "include themes/noctalia.conf";
    micro.settings.colorscheme = "noctalia";
    noctalia = {
      enable = true;
      settings = {
        audio.enable_overdrive = true;
        bar.widgets = {
          auto_hide = true;
          border = "primary";
          border_width = 1;
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
          start = [
            "workspaces"
            "media"
          ];
        };
        control_center.shortcuts = [
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
        desktop_widgets.enabled = false;
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
        location.auto_locate = true;
        lockscreen_widgets = {
          enabled = true;
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
                clock_style = "analog";
                format = "{:%H:%M}";
              };
              type = "clock";
            };
          };
          widget_order = [
            "lockscreen-login-box@eDP-1"
            "lockscreen-widget-0000000000000001"
          ];
        };
        notification.layer = "overlay";
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
        plugins.enabled = [
          "noctalia/bongocat"
          "noctalia/screen_recorder"
          "noctalia/kaomoji"
          "oldirtty/color_picker"
          "nightwatch75/file-search"
          "cleboost/ssh-launcher"
        ];
        shell = {
          avatar_path = "~/.face";
          launcher = {
            categories = false;
            compact = true;
            layout = "simple";
            show_app_origin_indicator = false;
          };
          niri_overview_type_to_launch_enabled = true;
          panel = {
            control_center_placement = "centered";
            launcher_app_grid = true;
            launcher_compact = true;
            session_placement = "floating";
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
          session.actions = [
            {
              action = "lock";
              shortcut = "1";
            }
            {
              action = "shutdown";
              shortcut = "2";
              variant = "destructive";
            }
            {
              action = "reboot";
              shortcut = "3";
            }
            {
              action = "logout";
              shortcut = "4";
            }
          ];
          shadow.alpha = 0.5;
          show_location = false;
          telemetry_enabled = true;
          umbriel_audio_provider_enabled = true;
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
              "starship"
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
              "ratune"
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
              "zapfast"
              "driftwm"
              "jay"
              "blender"
              "darktable"
              "gimp"
              "inkscape"
              "lazyvim"
              "libreoffice"
              "micro"
              "musescore"
              "neovim"
              "obsidian"
              "vscode"
              "zed"
              "archetype-pokemmo"
              "heroiclauncher"
              "pandora-launcher"
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
              "speedcrunch"
              "strata"
              "thunderbird"
              "zathura"
              "zellij"
              "fcitx5"
              "gruvbox-plus-icons"
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
              "oh-my-posh"
              "rio"
              "superfile"
              "surgedm"
              "tmux"
              "tuios"
              "yazi"
            ];
          };
        };
        wallpaper = {
          automation = {
            enabled = true;
            recursive = true;
          };
          directory = "~/Pictures/wallpapers";
        };
        widget = {
          battery.display_mode = "graphic";
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
          notifications.hide_when_no_unread = true;
          recorder.type = "noctalia/screen_recorder:recorder";
          volume.actions = {
            scroll_down = "volume-down 1%";
            scroll_up = "volume-up 1%";
          };
          workspaces = {
            hide_when_empty = true;
            labels_only_when_occupied = true;
            show_labels = false;
          };
        };
      };
    };
    nvf.settings.vim = {
      additionalRuntimePaths = [ "${config.xdg.configHome}/nvim" ];
      extraPlugins.base16-nvim = {
        package = pkgs.vimPlugins.base16-nvim;
        setup = ''
          local ok, matugen = pcall(require, 'matugen')
          if ok then
            matugen.setup()
          end
        '';
      };
    };
    opencode.tui.theme = "matugen";
    pi-coding-agent.settings.theme = "noctalia";
    rio.settings.theme = "noctalia";
    superfile.settings.theme = "noctalia";
    television.settings.preview.env.BAT_THEME = "noctalia";
    tmux.extraConfig = "source-file ~/.config/tmux/themes/noctalia.conf";
    vicinae.settings.theme = "noctalia";
    yazi.theme.flavor.user = "noctalia";
    zathura.extraConfig = "include noctaliarc";
    zed-editor.userSettings.theme = {
      dark = "Noctalia";
      light = "Noctalia";
      mode = "system";
    };
    zellij.settings.theme = "noctalia";
  };
}
