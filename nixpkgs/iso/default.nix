{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  environment.systemPackages = [
    pkgs.disko
  ];
  isoImage.forceTextMode = true;
  nixpkgs.hostPlatform = "iso";
}
