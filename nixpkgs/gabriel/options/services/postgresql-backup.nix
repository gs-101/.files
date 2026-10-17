{ config, ... }:
{
  services = {
    postgresqlBackup = {
      enable = true;
      backupAll = true;
    };
    restic.backups.google-drive.paths = [
      config.services.postgresqlBackup.location
    ];
  };
}
