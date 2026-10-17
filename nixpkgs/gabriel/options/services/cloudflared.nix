{
  config,
  lib,
  pkgs,
  ...
}:
let
  domain = "gs-101.dev";
in
{
  services = {
    caddy = {
      globalConfig = ''
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
        hash = "sha256-xRJ5evsAJ2akg47j3Bt6YDXJOgX88B/rKNP50KSVyNY=";
      };
    };
    cloudflared = {
      enable = true;
      tunnels."c21cf6f5-33ff-4c66-8c38-a8316d86e1de" = {
        credentialsFile = config.sops.secrets.cloudflared.path;
        default = "http_status:404";
        ingress = lib.mkMerge [
          (lib.mkIf (config.virtualisation.oci-containers.containers ? "any2nix") {
            "any2nix.${domain}" = "http://127.0.0.1:${
              builtins.head (
                lib.splitString ":" (builtins.head config.virtualisation.oci-containers.containers."any2nix".ports)
              )
            }";
          })
          (lib.optionalAttrs config.services.forgejo.enable {
            "git.${domain}" = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
          })
          (lib.optionalAttrs config.services.zipline.enable {
            "zipline.${domain}" = "http://127.0.0.1:${toString config.services.zipline.settings.CORE_PORT}";
          })
        ];
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
