{ lib, pkgs, ... }:

{
  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    stateVersion = "24.11";

    packages = with pkgs; [
      # pass
      # bat
      # eza
      # ripgrep
      # fira-code
      # rofi-wayland
      # kitty
      # librewolf
      # sway
      # waybar
      # gnupg
      # gnumake
    ];

    file = {
      
    };

    sessionVariables = {

    };
  };

  programs = with pkgs; {
    home-manager.enable = true;
    # emacs = {
    #   enable = true;
    #   package = emacs-unstable;
    # };
  };
}
