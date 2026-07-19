{ config, host, ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          redir /blocky /blocky/
          handle_path /blocky/* {
            reverse_proxy  localhost:${toString config.services.blocky.settings.ports.http}
          }
        '';
      };
    };
    blocky = {
      enable = true;
      settings = {
        blocking = {
          clientGroupsBlock = {
            default = [
              "hagezi"
              "malware_filter"
              "other"
            ];
          };
          denylists = {
            hagezi = [
              # HaGeZi's DynDNS Blocklist
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/dyndns.txt"
              # HaGeZi's Gambling DNS Blocklist
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/gambling.txt"
              # HaGeZi's NSFW DNS Blocklist
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/nsfw.txt"
              # HaGeZi's Threat Intelligence Feeds DNS Blocklist
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/tif.txt"
              # HaGeZi's Ultimate DNS Blocklist
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/ultimate.txt"
            ];
            malware_filter = [
              # Malicious Domains Wildcard Asterisk Blocklist
              "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-wildcard.txt"
              # Phishing Wildcard Asterisk Blocklist
              "https://malware-filter.gitlab.io/malware-filter/phishing-filter-wildcard.txt"
            ];
            other = [
              # Blocking with ad server and tracking server hostnames
              "https://pgl.yoyo.org/adservers/serverlist.php?showintro=1&mimetype=plaintext"
              # how to make the internet not suck (as much)
              "https://someonewhocares.org/hosts/hosts"
              # StevenBlack/hosts with the gambling and porn extensions
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"
            ];
          };
        };
        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
        };
        ports = {
          http = 4000;
        };
        upstreams.groups.default = [
          "https://dns.digitale-gesellschaft.ch/dns-query"
          "https://dns.quad9.net/dns-query"
          "https://security.cloudflare-dns.com/dns-query"
        ];
      };
    };
  };
}
