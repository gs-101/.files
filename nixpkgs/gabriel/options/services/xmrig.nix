{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot.kernel.sysctl = {
    "vm.nr_hugepages" = 1280;
  };
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = {
        enable = true;
        "huge-pages" = true;
        "max-threads-hint" = 75;
      };
      cuda = false;
      pools = [
        {
          keepalive = true;
          pass = config.networking.hostName;
          tls = true;
          url = "pool.supportxmr.com:443";
          user = "84JwhXmsFsRZpcoaQPcFjm8N7Fw9C71Av1ZHXXR4faDXZT9n4DFUxGeWxLpWKg32xFi7g2dDfQB2pC8PMw6RSjk3CbAHiiy";
        }
      ];
      opencl = false;
    };
  };
}
