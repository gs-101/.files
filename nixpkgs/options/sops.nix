{
  config,
  host,
  lib,
  username,
  ...
}:
{
  imports = [
    ../../shared/options/sops.nix
  ];
  sops.secrets = {
    miniflux = lib.mkIf config.services.miniflux.enable {
      mode = "0400";
    };
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
