{
  config,
  lib,
  ...
}:
{
  disabledModules = [ "services/misc/redlib.nix" ];

  options.services.redlib.enable = lib.mkEnableOption "redlib";

  config = lib.mkIf config.services.redlib.enable {
    virtualisation.oci-containers.containers.redlib = {
      image = "quay.io/redlib/redlib:latest";
      ports = [
        "8081:8080"
      ];
    };
  };
}
