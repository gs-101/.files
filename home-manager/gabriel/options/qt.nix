{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.breeze
  ];
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
        custom_palette = true;
        style = "Breeze";
      };
    };
    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        style = "Breeze";
      };
    };
    style = {
      name = "qt6ct-style";
      package = pkgs.qt6Packages.qt6ct;
    };
  };
}
