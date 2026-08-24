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
  networking.firewall = {
    interfaces.tailscale0 = {
      allowedTCPPorts = [
        53
        80
        443
      ];
      allowedUDPPorts = [ 53 ];
    };
    trustedInterfaces = [ "tailscale0" ];
  };
  services = {
    caddy = {
      enable = true;
      globalConfig = ''
        email gabrielsantosdesouza@disroot.org
        acme_ca https://acme-v02.api.letsencrypt.org/directory
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
        hash = "sha256-7GoH8YLCoPmPExQxoga2FHB58zQDoZVf1BBwkVi0SsQ=";
      };
      virtualHosts = lib.mkMerge [
        (lib.mkIf config.services.anki-sync-server.enable {
          "anki-sync-server.${domain}".extraConfig = ''
            reverse_proxy ${config.services.anki-sync-server.address}:${toString config.services.anki-sync-server.port}
          '';
        })
        (lib.mkIf config.services.blocky.enable {
          "blocky.${domain}".extraConfig = ''
            reverse_proxy localhost:${toString config.services.blocky.settings.ports.http}
          '';
        })
        (lib.mkIf config.services.forgejo.enable {
          "git.${domain}".extraConfig = ''
            reverse_proxy localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}
          '';
        })
        (lib.mkIf config.services.miniflux.enable {
          "miniflux.${domain}".extraConfig = ''
            reverse_proxy ${config.services.miniflux.config.LISTEN_ADDR}
          '';
        })
        (lib.mkIf config.services.rsshub.enable {
          "rsshub.${domain}".extraConfig = ''
            reverse_proxy localhost:${toString config.services.rsshub.settings.PORT}
          '';
        })
        (lib.mkIf config.services.syncthing.enable {
          "syncthing.${domain}".extraConfig = ''
            reverse_proxy ${config.services.syncthing.guiAddress} {
              header_up Host localhost
            }
          '';
        })
        (lib.mkIf config.services.wakapi.enable {
          "wakapi.${domain}".extraConfig = ''
            reverse_proxy localhost:${toString config.services.wakapi.settings.server.port}
          '';
        })
      ];
    };
    tailscale = {
      enable = true;
      permitCertUid = config.services.caddy.user;
    };
  };
  sops.secrets.cloudflare_api_token_env = {
    mode = "0444";
  };
  systemd.services.caddy.serviceConfig = {
    EnvironmentFile = config.sops.secrets.cloudflare_api_token_env.path;
  };
}
