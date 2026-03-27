{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
  ];
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (
      e: with e; [
        pass-file
        pass-otp
        pass-update
      ]
    );
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    };
  };
}
