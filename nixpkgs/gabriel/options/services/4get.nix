{
  config,
  lib,
  ...
}:
{
  options.services."4get".enable = lib.mkEnableOption "4get";

  config = lib.mkIf config.services."4get".enable {
    virtualisation.oci-containers.containers."4get" = {
      image = "luuul/4get:1.0.52";
      ports = [
        "8079:80"
      ];
    };
  };
}
