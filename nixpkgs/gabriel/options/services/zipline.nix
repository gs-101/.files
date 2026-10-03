{ config, ... }:
{
  services.zipline = {
    enable = true;
    environmentFiles = [ config.sops.secrets.zipline.path ];
    settings = {
      CORE_PORT = 3002;
      FEATURES_OAUTH_REGISTRATION = "false";
      FEATURES_USER_REGISTRATION = "false";
      INVITES_ENABLED = "false";
    };
  };
  sops.secrets.zipline = { };
  # TODO: Remove this after crashes stop happening.
  systemd.services.zipline.environment.HOME = "/var/lib/zipline";
}
