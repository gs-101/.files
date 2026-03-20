{ pkgs, ... }:
let
  ghostty-cursor-shaders = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "4faa83e4b9306750fc8de64b38c6f53c57862db8";
    hash = "sha256-ruhEqXnWRCYdX5mRczpY3rj1DTdxyY3BoN9pdlDOKrE=";
  };
in
{
  home.sessionVariables = {
    # Fixes dead keys on ghostty, see:
    # https://github.com/ghostty-org/ghostty/discussions/8899
    GTK_IM_MODULE = "simple";
    TERM = "ghostty";
  };
  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    settings = {
      custom-shader = [
        "${ghostty-cursor-shaders}/cursor_warp.glsl"
      ];
      font-family = "monospace";
      theme = "noctalia";
    };
  };
}
