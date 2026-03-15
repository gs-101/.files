{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
      ];
      monospace = [
        "Monocraft"
        "Noto Sans Mono"
        "Noto Sans Mono CJK SC"
        "Noto Sans Mono CJK JP"
        "Noto Sans Mono CJK KR"
        "Noto Rashi Hebrew"
        "Symbols Nerd Font Mono"
      ];
      sansSerif = [
        "Aporetic Sans"
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans Hebrew"
        "Symbols Nerd Font"
      ];
      serif = [
        "Aporetic Serif"
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans Hebrew"
        "Symbols Nerd Font"
      ];
    };
  };
  home.packages = with pkgs; [
    aporetic
    monocraft
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
