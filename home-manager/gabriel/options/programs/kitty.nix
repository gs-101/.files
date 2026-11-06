{
  home = {
    sessionVariables.TERM = "kitty";
    shellAliases.icat = "kitty +kitten icat";
  };
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+enter" = "launch --cwd=current";
      "ctrl+shift+t" = "launch --type=tab --cwd=current";
    };
    settings = {
      cursor_trail = 1;
      paste_actions = "no-op";
      restore_session_after_logout = true;
    };
  };
}
