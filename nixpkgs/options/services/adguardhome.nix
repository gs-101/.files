{
  config,
  host,
  ...
}:
{
  services = {
    adguardhome = {
      enable = true;
      mutableSettings = true;
    };
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          handle_path /adguardhome* {
            reverse_proxy ${config.services.adguardhome.host}:${toString config.services.adguardhome.port}
          }
        '';
      };
    };
  };
}
