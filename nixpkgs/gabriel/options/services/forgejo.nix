{ config, ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${config.networking.hostName}.tailbf3a7f.ts.net".extraConfig = ''
        redir /forgejo /forgejo/
        route /forgejo/* {
          uri strip_prefix /forgejo
          reverse_proxy localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}
        }
        route /v2/* {
          reverse_proxy localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}
        }
      '';
    };
    forgejo = {
      enable = true;
      lfs.enable = true;
      # Removing the social aspects of Forgejo.
      settings = {
        actions.ENABLED = true;
        federation.ENABLED = false;
        picture = {
          DISABLE_GRAVATAR = true;
          ENABLE_FEDERATED_AVATAR = false;
        };
        repository = {
          DISABLED_REPO_UNITS = "repo.issues,repo.ext_issues,repo.pulls,repo.projects";
          DISABLE_FORKS = true;
          DISABLE_STARS = true;
          ENABLE_PUSH_CREATE_USER = true;
        };
        server = {
          DOMAIN = "${config.networking.hostName}.tailbf3a7f.ts.net";
          HTTP_PORT = 3001;
          ROOT_URL = "https://${config.networking.hostName}.tailbf3a7f.ts.net/forgejo/";
        };
        # Set to 'false' temporarily to create the sole user.
        service.DISABLE_REGISTRATION = true;
        "service.explore" = {
          DISABLE_ORGANIZATIONS_PAGE = true;
          DISABLE_USERS_PAGE = true;
        };
      };
    };
  };
}
