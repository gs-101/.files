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
    version = "4.4.0";
    src = pkgs.fetchFromGitHub {
      owner = "civilblur";
      repo = "youlag";
      tag = "v${version}";
      hash = "sha256-M/YCY0tWqks6ozYMmdindinldwq61ViQfa2+MOPoPZU=";
    };
  };
in
{
  services.freshrss = {
    enable = true;
    api.enable = true;
    baseUrl = "http://freshrss.home.local";
    defaultUser = username;
    extensions = with pkgs.freshrss-extensions; [
      youlag
    ];
    passwordFile = config.sops.secrets.freshrss.path;
    virtualHost = "freshrss.home.local";
  };
}
