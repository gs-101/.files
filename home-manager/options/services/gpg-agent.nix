{ pkgs, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableSshSupport = true;
      pinentry = {
        package = pkgs.pinentry-curses;
        program = "pinentry-curses";
      };
    };
  };
}
