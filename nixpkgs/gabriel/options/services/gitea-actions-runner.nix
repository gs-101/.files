{ config, pkgs, ... }:
{
  services.gitea-actions-runner = {
    instances.default = {
      enable = true;
      labels = [
        "ubuntu-latest:docker://node:20-bookworm"
      ];
      name = config.networking.hostName;
      tokenFile = config.sops.secrets.gitea_actions_runner.path;
      url = config.services.forgejo.settings.server.ROOT_URL;
    };
    package = pkgs.forgejo-runner;
  };
  sops.secrets.gitea_actions_runner = { };
  virtualisation.docker.enable = true;
}
