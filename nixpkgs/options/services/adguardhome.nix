{
  host,
  ...
}:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          handle_path /adguardhome* {
            reverse_proxy localhost:3000
          }
        '';
      };
    };
    adguardhome = {
      enable = true;
      mutableSettings = true;
    };
  };
}
