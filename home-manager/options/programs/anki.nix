{ pkgs, ... }:
{
  home.sessionVariables = {
    ANKI_WAYLAND = 1;
  };
  programs.anki = {
    enable = true;
    hideTopBar = true;
    theme = "followSystem";
    style = "native";
  };
}
