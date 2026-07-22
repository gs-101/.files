# TODO: Use DNS-over-TLS instead.

{ ... }:
{
  networking.nameservers = [
    "127.0.0.1"
    "9.9.9.9"
  ];
  services = {
    crab-hole = {
      enable = true;
      settings = {
        blocklist = {
          include_subdomains = true;
          lists = [
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
            # Malicious Domains Wildcard Asterisk Blocklist
            "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-wildcard.txt"
            # Phishing Wildcard Asterisk Blocklist
            "https://malware-filter.gitlab.io/malware-filter/phishing-filter-wildcard.txt"
            # Blocking with ad server and tracking server hostnames
            "https://pgl.yoyo.org/adservers/serverlist.php?showintro=1&mimetype=plaintext"
            # how to make the internet not suck (as much)
            "https://someonewhocares.org/hosts/hosts"
            # StevenBlack/hosts with the gambling and porn extensions
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"
          ];
        };
        downstream = [
          {
            listen = "0.0.0.0";
            port = 53;
            protocol = "udp";
          }
          {
            listen = "::";
            port = 53;
            protocol = "udp";
          }
        ];
        upstream = {
          name_servers = [
            # Mullvad.
            {
              ip = "194.242.2.2";
              protocol = "tls";
              server_name = "dns.mullvad.net";
              socket_addr = "193.19.108.2:853";
              trust_negative_responses = false;
            }
            # Quad9.
            {
              ip = "9.9.9.9";
              protocol = "tls";
              server_name = "dns.quad9.net";
              socket_addr = "9.9.9.9:853";
              trust_negative_responses = false;
            }
          ];
        };
      };
    };
    resolved.enable = false;
  };
}
