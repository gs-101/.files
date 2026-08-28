{
  services.wakapi = {
    enable = true;
    settings = {
      security.allow_signup = false;
      server.port = 3000;
    };
  };
}
