{ config, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [
        config.services.forgejo.user
        "gabriel"
      ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
