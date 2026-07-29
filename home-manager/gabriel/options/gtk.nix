{ pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-decoration-layout = "menu";
      };
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = "menu";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
