{
  config,
  lib,
  username,
  ...
}:
{
  imports = [
    ../../shared/options/sops.nix
  ];
  sops.secrets = {
    anki_sync_server = lib.mkIf config.services.anki-sync-server.enable {
    };
    miniflux = lib.mkIf config.services.miniflux.enable { };
    password = {
      neededForUsers = true;
    };
    ssh_aur_key = {
      path = "/home/${username}/.ssh/id_ed25519_aur";
      mode = "0400";
      owner = "${username}";
    };
    ssh_educational_key = {
      path = "/home/${username}/.ssh/id_ed25519_educational";
      mode = "0400";
      owner = "${username}";
    };
    ssh_personal_key = {
      path = "/home/${username}/.ssh/id_ed25519_personal";
      mode = "0400";
      owner = "${username}";
    };
  };
}
