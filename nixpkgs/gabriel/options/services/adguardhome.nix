{
  config,
  ...
}:
{
  services = {
    adguardhome = {
      enable = true;
      host = "127.0.0.1";
      mutableSettings = false;
      port = 3002;
      settings = {
        dns = {
          bind_hosts = [
            "100.75.42.86"
            "192.168.0.102"
            "127.0.0.1"
          ];
          bootstrap_dns = [
            "194.242.2.2"
            "9.9.9.9"
          ];
          cache_enabled = true;
          fallback_dns = [
            "https://dns.mullvad.net/dns-query"
            "https://dns.quad9.net/dns-query"
          ];
          upstream_dns = [
            "https://security.cloudflare-dns.com/dns-query"
          ];
          upstream_mode = "parallel";
        };
        filters = [
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_49.txt";
            name = "HaGeZi's Ultimate Blocklist";
            id = 1784513324;
          }
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_47.txt";
            name = "HaGeZi's Gambling Blocklist";
            id = 1784513326;
          }
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_55.txt";
            name = "HaGeZi's Badware Hoster Blocklist";
            id = 1784513332;
          }
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_71.txt";
            name = "HaGeZi's DNS Rebind Protection";
            id = 1784513333;
          }
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_44.txt";
            name = "HaGeZi's Threat Intelligence Feeds";
            id = 1784513335;
          }
          {
            enabled = true;
            url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/nsfw.txt";
            id = 1784513336;
          }
        ];
      };
    };
    caddy = {
      enable = true;
      virtualHosts."${config.networking.hostName}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          redir /adguardhome /adguardhome/
          handle_path /adguardhome/* {
            reverse_proxy ${config.services.adguardhome.host}:${toString config.services.adguardhome.port}
          }
        '';
      };
    };
  };
}
