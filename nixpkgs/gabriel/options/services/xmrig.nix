{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot = {
    kernel.sysctl = {
      "vm.nr_hugepages" = 1280;
    };
    kernelModules = [ "msr" ];
    kernelParams = [
      "default_hugepagesz=2M"
      "hugepagesz=1G"
      "hugepages=3"
    ];
  };
  powerManagement.cpuFreqGovernor = "performance";
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = {
        enable = true;
        "huge-pages" = true;
        "max-threads-hint" = 50;
      };
      cuda = false;
      pools = [
        {
          keepalive = true;
          pass = config.networking.hostName;
          tls = false;
          url = "monero.gs-101.dev:3333";
          user = "84JwhXmsFsRZpcoaQPcFjm8N7Fw9C71Av1ZHXXR4faDXZT9n4DFUxGeWxLpWKg32xFi7g2dDfQB2pC8PMw6RSjk3CbAHiiy";
        }
      ];
      opencl = false;
    };
  };
}
