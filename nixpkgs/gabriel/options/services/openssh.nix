{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "gabriel" ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
