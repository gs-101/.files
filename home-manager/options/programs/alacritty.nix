{ config, ... }:
{
  home.sessionVariables.TERM = "alacritty";
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        # Always blinking cursor.
        style = {
          blinking = "Always";
          shape = "Block";
        };
        vi_mode_style = {
          blinking = "Always";
          shape = "Block";
        };
      };
      env = {
        TERM = "alacritty-direct";
      };
      general = {
        import = [
          "${config.xdg.configHome}/alacritty/themes/noctalia.toml"
        ];
      };
      keyboard.bindings = [
        {
          action = "ToggleFullScreen";
          key = "F11";
          mods = "None";
        }
      ];
      selection = {
        save_to_clipboard = true;
      };
    };
  };
}
