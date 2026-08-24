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
      url = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}/";
    };
    package = pkgs.forgejo-runner;
  };
  sops.secrets.gitea_actions_runner = { };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
}
