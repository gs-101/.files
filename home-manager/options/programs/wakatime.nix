{ config, pkgs, ... }:
{
  home = {
    packages = [ pkgs.wakatime-cli ];
    sessionVariables = {
      WAKATIME_HOME = "${config.xdg.dataHome}/wakatime";
    };
  };
  xdg.configFile."wakatime/.wakatime.cfg".text = ''
    [settings]
    exclude_unknown_project = true
    offline                 = true
  '';
}
