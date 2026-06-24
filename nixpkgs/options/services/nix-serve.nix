{
  config,
  host,
  pkgs,
  ...
}:
{
  nix.settings = {
    substituters = [
      "http://nix-notebook:5000"
      "http://nix-pc:5000"
    ];
    trusted-public-keys = [
      "nix-notebook:VhHxAuujVLZBfNREt0wLv26lAxic4Nu/bCWIZesVk24="
      "nix-pc:3AvrbKsO36nA5Lh8byOZ+CM6LEk1LTvLufNBNGPyelM="
    ];
  };
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    secretKeyFile = config.sops.secrets."nix_serve_${host}".path;
  };
}
