{
  config,
  lib,
  ...
}:
{
  options.services.any2nix.enable = lib.mkEnableOption "any2nix";

  config = lib.mkIf config.services.any2nix.enable {
    virtualisation.oci-containers.containers."any2nix" = {
      image = "ghcr.io/gbr-ufs/any2nix-website:0.1.6";
      ports = [
        "3003:3000"
      ];
    };
  };
}
