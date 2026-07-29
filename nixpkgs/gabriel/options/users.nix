{ config, ... }:
{
  sops.secrets.password = {
    neededForUsers = true;
  };
  users = {
    mutableUsers = false;
    users.gabriel = {
      description = "Gabriel Santos";
      extraGroups = [
        "input"
        "networkmanager"
        "wheel"
      ];
      hashedPasswordFile = config.sops.secrets.password.path;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO"
      ];
    };
  };
}
