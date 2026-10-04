{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.breeze
  ];
  qt = {
    enable = true;
    qt5ctSettings.Appearance.style = "Breeze";
    qt6ctSettings.Appearance.style = "Breeze";
  };
}
