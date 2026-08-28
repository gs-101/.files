{ config, pkgs, ... }:
{
  services = {
    caddy = {
      globalConfig = ''
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
        hash = "sha256-7GoH8YLCoPmPExQxoga2FHB58zQDoZVf1BBwkVi0SsQ=";
      };
    };
    cloudflared = {
      enable = true;
      tunnels."c21cf6f5-33ff-4c66-8c38-a8316d86e1de" = {
        credentialsFile = config.sops.secrets.cloudflared.path;
        default = "http_status:404";
        ingress = {
          "git.gs-101.dev" = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
        };
      };
    };
  };
  sops.secrets = {
    cloudflare_api_token_env = {
      mode = "0444";
    };
    cloudflared = {
      mode = "0444";
    };
  };
  systemd.services.caddy.serviceConfig = {
    EnvironmentFile = config.sops.secrets.cloudflare_api_token_env.path;
  };
}
