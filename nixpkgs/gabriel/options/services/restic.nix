{ config, ... }:
{
  services.restic.backups.google-drive = {
    initialize = true;
    passwordFile = config.sops.secrets.rclone_google_drive.path;
    paths = [
      "/home"
      "/var/lib"
    ];
    rcloneConfigFile = config.sops.secrets.rclone.path;
    repository = "rclone:google-drive:Backups/restic";
    timerConfig = {
      OnCalendar = "daily";
      RandomizeDelaySec = "24h";
    };
  };
  sops.secrets.rclone = { };
  sops.secrets.rclone_google_drive = { };
}
