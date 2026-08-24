{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels."c21cf6f5-33ff-4c66-8c38-a8316d86e1de" = {
      credentialsFile = config.sops.secrets.cloudflared.path;
      default = "http_status:404";
      ingress = {
        "git.gs-101.dev" = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
      };
    };
  };
  sops.secrets.cloudflared = {
    mode = "0444";
  };
}
