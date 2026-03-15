{ ... }:
{
  xdg.configFile."wakatime/.wakatime.cfg".text = ''
    [settings]
    exclude_unknown_project = true
    offline                 = true
  '';
}
