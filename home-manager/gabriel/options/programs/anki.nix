{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.anki-bin ];
    sessionVariables = {
      ANKI_WAYLAND = 1;
    };
  };
}
