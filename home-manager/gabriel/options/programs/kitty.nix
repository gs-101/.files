{
  home.sessionVariables.TERM = "kitty";
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl-shift-enter" = "new_window_with_cmd";
    };
    settings = {
      cursor_trail = 1;
      paste_actions = "no-op";
    };
  };
}
