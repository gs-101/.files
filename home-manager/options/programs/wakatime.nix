{ config, pkgs, ... }:
{
  home.packages = [ pkgs.wakatime-cli ];
  xdg.configFile."wakatime/.wakatime.cfg".text = ''
    [settings]
    exclude_unknown_project = true
    offline                 = true
  '';
}
