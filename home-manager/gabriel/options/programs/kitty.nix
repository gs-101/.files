{
  home = {
    sessionVariables.TERM = "kitty";
    shellAliases.icat = "kitty +kitten icat";
  };
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+enter" = "launch --cwd=current";
    };
    settings = {
      cursor_trail = 1;
      paste_actions = "no-op";
    };
  };
}
