{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.anki ];
    sessionVariables = {
      ANKI_WAYLAND = 1;
    };
  };
}
