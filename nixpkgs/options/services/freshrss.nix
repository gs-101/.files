{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  youlag = pkgs.freshrss-extensions.buildFreshRssExtension rec {
    FreshRssExtUniqueId = "Youlag";
    pname = "youlag";
    version = "4.4.2";
    src = pkgs.fetchFromGitHub {
      owner = "civilblur";
      repo = "youlag";
      tag = "v${version}";
      hash = "sha256-ET5KgLONRScdZDZQUESynxXIZHjU8f9hx8OqiKHGGaU=";
    };
  };
in
{
  services.freshrss = {
    enable = true;
    api.enable = true;
    baseUrl = "http://nix-pc";
    defaultUser = username;
    extensions = with pkgs.freshrss-extensions; [
      youlag
    ];
    passwordFile = config.sops.secrets.freshrss.path;
    virtualHost = "nix-pc";
  };
}
