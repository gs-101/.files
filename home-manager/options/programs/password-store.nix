{ config, pkgs, ... }:
{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (
      exts: with exts; [
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
