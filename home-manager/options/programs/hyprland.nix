{
  config,
  lib,
  pkgs,
  ...
}:
let
  hyprshot = "${lib.getExe pkgs.hyprshot}";
  noctalia-shell = "${lib.getExe pkgs.noctalia-shell}";
in
{
  imports = [
    ./noctalia-shell.nix
  ];
  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Pictures/screenshots";
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
      # pkgs.hyprlandPlugins.hyprspace
    ];
    settings = {
      source = "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf";
      exec-once = [
        "${noctalia-shell} --no-duplicate"
      ];
      animations = {
        enabled = true;
        workspace_wraparound = true;
        animation = [
          "global, 1, 10, default"
          "windows, 1, 4.79, easeOutQuint"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fade, 1, 3.03, quick"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "border, 1, 5.39, easeOutQuint"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
      };
      bind = [
        "SUPER, Return, exec, $TERM"
        "SUPER, X, exec, ${noctalia-shell} ipc call launcher toggle"
        "SUPER, E, exec, $VISUAL"
        "SUPER, V, exec, ${noctalia-shell} ipc call launcher clipboard"
        "SUPER, ., exec, ${noctalia-shell} ipc call launcher emoji"
        "SUPER, N, exec, ${noctalia-shell} ipc call notifications toggleHistory"
        "SUPER, C,  exec, ${lib.getExe pkgs.hyprpicker} -an"
        ", PRINT, exec, ${hyprshot} -m output"
        "SHIFT, PRINT, exec, ${hyprshot} -m window"
        "CTRL, PRINT, exec, ${hyprshot} -m region"
        "SUPER, B, exec, ${noctalia-shell} ipc call bar toggle"
        "SUPER CTRL, C, exec, bookmarks-copy"
        "SUPER CTRL, V, exec, bookmarks-paste"
        "SUPER, escape, exit"
        # "SUPER, TAB, overview:toggle"
        "SUPER, Q, killactive"
        "SUPER, F, togglefloating"
        "SUPER, left, movefocus, l"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER, right, movefocus, r"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER, up, movefocus, u"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER, down, movefocus, d"
        "SUPER SHIFT, down, movewindow, d"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, ${noctalia-shell} ipc call volume increase"
        ", XF86AudioLowerVolume, exec, ${noctalia-shell} ipc call volume decrease"
        ", XF86AudioMute, exec, ${noctalia-shell} ipc call volume muteOutput"
        ", XF86AudioMicMute, exec, ${noctalia-shell} ipc call volume muteInput"
        ", XF86MonBrightnessUp, exec, ${noctalia-shell} call brightness increase"
        ", XF86MonBrightnessDown, exec, ${noctalia-shell} call brightness decrease"
      ];
      bindl = [
        ", XF86AudioNext, exec, ${noctalia-shell} call media next"
        ", XF86AudioPause, exec, ${noctalia-shell} call media pause"
        ", XF86AudioPlay, exec, ${noctalia-shell} call media play"
        ", XF86AudioPrev, exec, ${noctalia-shell} call media previous"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      binds = {
        allow_workspace_cycles = true;
        scroll_event_delay = 0;
        workspace_back_and_forth = true;
      };
      cursor = {
        hide_on_key_press = true;
        hide_on_touch = true;
        no_hardware_cursors = 1;
      };
      decoration = {
        rounding = 24;
        rounding_power = 2.0;
        blur = {
          enabled = false;
          xray = true;
        };
        shadow = {
          enabled = false;
        };
      };
      device = [
        {
          name = "at-translated-set-2-keyboard";
          kb_layout = "br";
        }
        {
          name = "casue-usb-kbx";
          kb_layout = "br";
        }
      ];
      general = {
        gaps_out = 5;
        snap = {
          enabled = true;
          respect_gaps = true;
        };
      };
      group = {
        groupbar = {
          rounding = 24;
        };
      };
      input = {
        float_switch_override_focus = 2;
        kb_options = "ctrl:nocaps";
        numlock_by_default = true;
      };
      layerrule = {
        blur = true;
        blur_popups = true;
        name = "noctalia";
        ignore_alpha = 0.5;
        "match:namespace" = "noctalia-background-.*$";
      };
      master = {
        mfact = 0.70;
        new_status = "master";
        orientation = "center";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_scale_notification = false;
        disable_splash_rendering = true;
        enable_swallow = true;
        focus_on_activate = true;
        force_default_wallpaper = 0;
        swallow_regex = ".*";
      };
    };
  };
}
