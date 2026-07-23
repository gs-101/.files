{ username, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ username ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
