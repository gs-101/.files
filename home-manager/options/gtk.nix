{ pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk3.theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;      
    };
  };
}
