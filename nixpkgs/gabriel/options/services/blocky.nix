{
  config,
  ...
}:
{
  services = {
    blocky = {
      enable = true;
      settings = {
        blocking = {
          clientGroupsBlock = {
            default = [
              "default"
            ];
          };
          denylists = {
            default = [
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_49.txt"
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_47.txt"
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_55.txt"
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_71.txt"
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_44.txt"
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/nsfw.txt"
            ];
          };
        };
        bootstrapDns = [
          "tcp+udp:194.242.2.2"
          "tcp+udp:9.9.9.9"
        ];
        caching = {
          maxTime = "30m";
          minTime = "5m";
          prefetching = true;
        };
        customDNS.mapping."gs-101.dev" = "100.75.42.86";
        ports = {
          dns = 53;
          http = 4000;
        };
        prometheus = {
          enable = true;
          path = "/metrics";
        };
        upstreams = {
          groups = {
            default = [
              "https://security.cloudflare-dns.com/dns-query"
              "https://dns.mullvad.net/dns-query"
              "https://dns.quad9.net/dns-query"
            ];
          };
          strategy = "parallel_best";
        };
      };
    };
    resolved.settings.Resolve = {
      DNSStubListener = "no";
    };
  };
}
