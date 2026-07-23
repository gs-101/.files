{
  host,
  username,
  system,
  ...
}:
{
  imports = [
    ./${username}.nix
    ./options/disko/${host}.nix
    ./options/boot.nix
    ./options/i18n.nix
    ./options/nix/settings.nix
    ./options/services/tailscale.nix
  ];
  networking.hostName = host;
  nixpkgs.hostPlatform = system;
  security.rtkit.enable = true;
}
