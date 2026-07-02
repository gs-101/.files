{
  modulesPath,
  pkgs,
  system,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./options/nix/settings.nix
  ];
  environment.systemPackages = with pkgs; [
    disko
  ];
  isoImage.forceTextMode = true;
  nixpkgs.hostPlatform = system;
  programs = {
    nano.enable = false;
  };
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO"
  ];
}
