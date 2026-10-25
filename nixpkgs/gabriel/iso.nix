{
  imports = [
    ./options/nix.nix
  ];
  programs = {
    nano.enable = false;
    neovim.enable = true;
  };
  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO"
  ];
}
