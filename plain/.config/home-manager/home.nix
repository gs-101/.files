{ lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    stateVersion = "24.11";

    sessionVariables = {
      ANKI_WAYLAND = 1;
    };

    packages = with pkgs; [
      anki-bin
      gh
      television
      wakatime-cli
      wasabiwallet
    ];
  };

  programs = with pkgs; {
    home-manager.enable = true;
    password-store = {
      enable = true;
      package = pass.withExtensions (exts: with exts; [
        pass-file
        pass-otp
        pass-update
      ]);
    };
  };

  targets.genericLinux.enable = true;
}
