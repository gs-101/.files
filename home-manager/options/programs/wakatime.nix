{ config, pkgs, ... }:
{
  home = {
    packages = [ pkgs.wakatime-cli ];
    sessionVariables = {
      WAKATIME_HOME = "${config.xdg.dataHome}/wakatime";
    };
  };
}
