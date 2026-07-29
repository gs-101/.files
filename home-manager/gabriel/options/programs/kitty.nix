{
  home.sessionVariables.TERM = "kitty";
  programs.kitty = {
    enable = true;
    extraConfig = "include themes/noctalia.conf";
    settings = {
      cursor_trail = 1;
    };
  };
}
