{
  services.wakapi = {
    enable = true;
    settings = {
      security = {
        allow_signup = false;
      };
      server = {
        port = 3000;
        public_url = "https://wakapi.gs-101.dev/";
      };
    };
  };
}
