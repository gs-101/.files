{ pkgs, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry = {
        package = pkgs.pinentry-qt;
      };
    };
  };
}
