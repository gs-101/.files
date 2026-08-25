{ config, ... }:
{
  services = {
    forgejo = {
      enable = true;
      lfs.enable = true;
      # Removing the social aspects of Forgejo.
      settings = {
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "https://github.com";
        };
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
          DOMAIN = "git.gs-101.dev";
          HTTP_PORT = 3001;
          LANDING_PAGE = "explore";
          ROOT_URL = "https://git.gs-101.dev/";
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
