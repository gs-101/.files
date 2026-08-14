{ lib, pkgs, ... }:
let
  noctalia = lib.getExe pkgs.noctalia;
in
{
  imports = [
    ./noctalia.nix
  ];
  home.packages = [ pkgs.hyprpicker ];
  wayland.windowManager.niri = {
    enable = true;
    checkConfig = false;
    settings = {
      binds = {
        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;
        "Mod+0".focus-workspace = 10;
        "Mod+C" = {
          _props.hotkey-overlay-title = "Spawn Color Picker";
          spawn = [
            "${noctalia}"
            "msg"
            "panel-toggle"
            "oldirtty/color_picker:panel"
          ];
        };
        "Mod+Down".focus-window-down = { };
        "Mod+E" = {
          _props.hotkey-overlay-title = "Spawn Editor";
          spawn-sh = "$VISUAL";
        };
        "Mod+Escape".quit = { };
        "Mod+F".toggle-window-floating = { };
        "Mod+Left".focus-column-left = { };
        "Mod+Period" = {
          _props.hotkey-overlay-title = "Spawn Emoji Menu";
          spawn = [
            "${noctalia}"
            "msg"
            "panel-toggle"
            "launcher"
            "/emo"
          ];
        };
        "Mod+Q".close-window = { };
        "Mod+Return" = {
          _props.hotkey-overlay-title = "Spawn Terminal";
          spawn-sh = "$TERM";
        };
        "Mod+Right".focus-column-right = { };
        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;
        "Mod+Shift+0".move-column-to-workspace = 10;
        "Mod+Shift+Down".move-window-down = { };
        "Mod+Shift+Left".move-column-left = { };
        "Mod+Shift+Right".move-column-right = { };
        "Mod+Shift+Up".move-window-up = { };
        "Mod+Tab".toggle-overview = { };
        "Mod+TouchpadScrollDown".focus-workspace-down = { };
        "Mod+TouchpadScrollLeft".focus-column-left = { };
        "Mod+TouchpadScrollRight".focus-column-right = { };
        "Mod+TouchpadScrollUp".focus-workspace-up = { };
        "Mod+V" = {
          _props.hotkey-overlay-title = "Spawn Clipboard Manager";
          spawn = [
            "${noctalia}"
            "msg"
            "panel-toggle"
            "clipboard"
          ];
        };
        "Mod+WheelScrollDown".focus-workspace-down = { };
        "Mod+WheelScrollLeft".focus-column-left = { };
        "Mod+WheelScrollRight".focus-column-right = { };
        "Mod+WheelScrollUp".focus-workspace-up = { };
        "Mod+Up".focus-window-up = { };
        "Mod+X" = {
          _props.hotkey-overlay-title = "Spawn Menu";
          spawn = [
            "${noctalia}"
            "msg"
            "panel-toggle"
            "launcher"
          ];
        };
        "Print" = {
          _props.hotkey-overlay-title = "Take a Screenshot of the Screen";
          spawn = [
            "${noctalia}"
            "msg"
            "screenshot-fullscreen"
          ];
        };
        "Shift+Print" = {
          _props.hotkey-overlay-title = "Take a Screenshot of the Current Region";
          spawn = [
            "${noctalia}"
            "msg"
            "screenshot-region"
          ];
        };
        "XF86AudioLowerVolume" = {
          spawn = [
            "${noctalia}"
            "msg"
            "volume-down"
          ];
        };
        "XF86AudioMicMute" = {
          spawn = [
            "${noctalia}"
            "msg"
            "mic-mute"
          ];
        };
        "XF86AudioMute" = {
          spawn = [
            "${noctalia}"
            "msg"
            "volume-mute"
          ];
        };
        "XF86AudioNext".spawn = [
          "${noctalia}"
          "msg"
          "media"
          "next"
        ];
        "XF86AudioPause".spawn = [
          "${noctalia}"
          "msg"
          "media"
          "toggle"
        ];
        "XF86AudioPlay".spawn = [
          "${noctalia}"
          "msg"
          "media"
          "toggle"
        ];
        "XF86AudioPrev".spawn = [
          "${noctalia}"
          "msg"
          "media"
          "previous"
        ];
        "XF86AudioRaiseVolume" = {
          spawn = [
            "${noctalia}"
            "msg"
            "volume-up"
          ];
        };
        "XF86MonBrightnessDown".spawn = [
          "${noctalia}"
          "msg"
          "brightness-down"
        ];
        "XF86MonBrightnessUp".spawn = [
          "${noctalia}"
          "msg"
          "brightness-up"
        ];
      };
      cursor = {
        hide-after-inactive-ms = 1000;
        hide-when-typing = { };
      };
      include = "noctalia.kdl";
      input = {
        focus-follows-mouse = { };
        keyboard = {
          numlock = { };
          repeat-delay = 600;
          repeat-rate = 25;
          xkb = {
            layout = "br";
            options = "ctrl:nocaps";
          };
        };
        mouse.accel-profile = "flat";
        touchpad = {
          accel-profile = "flat";
          disabled-on-external-mouse = { };
          drag = true;
          drag-lock = { };
          dwt = { };
          dwtp = { };
          tap = { };
        };
        trackball.accel-profile = "flat";
        trackpoint.accel-profile = "flat";
        workspace-auto-back-and-forth = { };
      };
      layout = {
        always-center-single-column = { };
        background-color = "transparent";
        border.off = { };
        default-column-display = "tabbed";
        focus-ring.width = 1;
        gaps = 5;
        tab-indicator.hide-when-single-tab = { };
      };
      prefer-no-csd = { };
      spawn-at-startup = [
        "${noctalia}"
      ];
      _children = [
        {
          layer-rule = {
            match._props.namespace = "^noctalia-wallpaper*";
            place-within-backdrop = true;
          };
        }
        {
          window-rule = {
            clip-to-geometry = true;
            geometry-corner-radius = 24;
          };
        }
        {
          window-rule = {
            match._props.app-id = "xdg-desktop-portal-gtk";
            open-floating = true;
          };
        }
        {
          window-rule = {
            match._props.app-id = "dev.noctalia.Noctalia.Settings";
            open-floating = true;
          };
        }
      ];
    };
  };
}
