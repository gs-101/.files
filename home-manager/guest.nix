{ ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
      ];
      monospace = [
        "Noto Sans Mono"
        "Noto Sans Mono CJK SC"
        "Noto Sans Mono CJK JP"
        "Noto Sans Mono CJK KR"
        "Noto Rashi Hebrew"
        "Symbols Nerd Font Mono"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans Hebrew"
        "Symbols Nerd Font"
      ];
      serif = [
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans Hebrew"
        "Symbols Nerd Font"
      ];
    };
  };
  home = {
    homeDirectory = "/home/guest";
    username = "guest";
    packages = with pkgs; [
      gimp
      inkscape
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    stateVersion = "25.11";
  };
  nixpkgs = {
    config.allowUnfree = true;
  };
  programs.gnome-shell.enable = true;
}
