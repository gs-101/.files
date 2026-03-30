{ ... }:
{
  imports = [
    ../../shared/options/sops.nix
  ];
  sops.secrets = {
    authinfo = { };
    disroot = { };
  };
}
