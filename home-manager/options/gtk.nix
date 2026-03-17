{ pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-decoration-layout = "menu";
      };
      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
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
