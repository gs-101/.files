{
  config,
  lib,
  ...
}:
let
  domain = "gs-101.dev";
  containerEnvironments = {
    "4get" = {
      FOURGET_PROTO = "http";
      FOURGET_SERVER_NAME = "4get.${domain}";
    };
  };
in
{
  options.virtualisation.oci-containers.containers = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          config = lib.mkIf (containerEnvironments ? ${name}) {
            environment = containerEnvironments.${name};
          };
        }
      )
    );
  };
  config = {
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
        '';
        virtualHosts = lib.mkMerge [
          (lib.mkIf (config.virtualisation.oci-containers.containers ? "4get") {
            "4get.${domain}".extraConfig = ''
              reverse_proxy localhost:${
                builtins.head (
                  lib.splitString ":" (builtins.head config.virtualisation.oci-containers.containers."4get".ports)
                )
              }
            '';
          })
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
          (lib.mkIf config.services.navidrome.enable {
            "navidrome.${domain}".extraConfig = ''
              reverse_proxy localhost:${toString config.services.navidrome.settings.Port}
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
          (lib.mkIf config.services.zipline.enable {
            "zipline.${domain}".extraConfig = ''
              reverse_proxy localhost:${toString config.services.zipline.settings.CORE_PORT}
            '';
          })
        ];
      };
      forgejo.settings.server = {
        DOMAIN = "git.${domain}";
        ROOT_URL = "https://git.${domain}/";
      };
      miniflux.config.BASE_URL = "https://miniflux.${domain}/";
      tailscale = {
        enable = true;
        permitCertUid = config.services.caddy.user;
      };
      wakapi.settings.server.public_url = "https://wakapi.${domain}/";
      zipline.settings = {
        CORE_DEFAULT_DOMAIN = "zipline.${domain}";
        CORE_RETURN_HTTPS_URLS = "true";
        CORE_TRUST_PROXY = "true";
        MFA_TOTP_ENABLED = "true";
        MFA_TOTP_ISSUER = "Zipline";
      };
    };
  };
}
