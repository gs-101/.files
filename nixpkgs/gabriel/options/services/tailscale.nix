{
  config,
  lib,
  ...
}:
let
  domain = "gs-101.dev";
  containerReverseProxy =
    {
      container,
      subdomain ? container,
      port ?
        let
          ports = config.virtualisation.oci-containers.containers.${container}.ports or [ ];
        in
        if ports != [ ] then builtins.head (lib.splitString ":" (builtins.head ports)) else null,
      listenAddr ? "localhost:${toString port}",
      extraDirectives ? "",
      environment ? { },
    }:
    lib.mkIf (config.services.${container}.enable or false) {
      services.caddy.virtualHosts."${subdomain}.${domain}".extraConfig = ''
        reverse_proxy ${listenAddr} ${extraDirectives}
      '';
      virtualisation.oci-containers.containers.${container}.environment = environment;
    };
  reverseProxy =
    {
      service,
      subdomain ? service,
      port ? null,
      listenAddr ? "localhost:${toString port}",
      extraDirectives ? "",
    }:
    lib.mkIf (config.services.${service}.enable or false) {
      "${subdomain}.${domain}".extraConfig = ''
        reverse_proxy ${listenAddr} ${extraDirectives}
      '';
    };
in
lib.mkMerge [
  (containerReverseProxy {
    container = "4get";
    environment = {
      "FOURGET_PROTO" = "http";
      "FOURGET_SERVER_NAME" = "4get.${domain}";
    };
  })
  (containerReverseProxy {
    container = "any2nix";
  })
  (containerReverseProxy {
    container = "redlib";
  })
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
        '';
        virtualHosts = lib.mkMerge [
          (reverseProxy {
            service = "anki-sync-server";
            listenAddr = "${config.services.anki-sync-server.address}:${toString config.services.anki-sync-server.port}";
          })
          (reverseProxy {
            service = "atuin";
            port = config.services.atuin.port;
          })
          (reverseProxy {
            service = "blocky";
            port = config.services.blocky.settings.ports.http;
          })
          (reverseProxy {
            service = "forgejo";
            subdomain = "git";
            port = config.services.forgejo.settings.server.HTTP_PORT;
          })
          (reverseProxy {
            service = "miniflux";
            listenAddr = config.services.miniflux.config.LISTEN_ADDR;
          })
          (reverseProxy {
            service = "navidrome";
            port = config.services.navidrome.settings.Port;
          })
          (reverseProxy {
            service = "rsshub";
            port = config.services.rsshub.settings.PORT;
          })
          (reverseProxy {
            service = "syncthing";
            listenAddr = config.services.syncthing.guiAddress;
            extraDirectives = ''
              {
                header_up Host localhost
              }'';
          })
          (reverseProxy {
            service = "wakapi";
            port = config.services.wakapi.settings.server.port;
          })
          (reverseProxy {
            service = "zipline";
            port = config.services.zipline.settings.CORE_PORT;
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
  }
]
