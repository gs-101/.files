{
  config,
  fullName,
  ...
}:
{
  imports = [
    ./options/sops.nix
    ./options/services/tailscale.nix
    ./options/virtualisation/podman.nix
  ];
  programs = {
    dconf.enable = true;
    nano.enable = false;
    nix-ld.enable = true;
  };
  users = {
    mutableUsers = false;
    users = {
      gabriel = {
        description = fullName;
        extraGroups = [
          "input"
          "networkmanager"
          "podman"
          "wheel"
        ];
        hashedPasswordFile = config.sops.secrets.password.path;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO"
        ];
      };
    };
  };
  virtualisation.containers.enable = true;
}
