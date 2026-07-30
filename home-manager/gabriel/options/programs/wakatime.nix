{ config, pkgs, ... }:
{
  home.packages = [ pkgs.wakatime-cli ];
  sops.secrets.wakatime = { };
  xdg.configFile."wakatime/.wakatime.cfg".text = ''
    [settings]
    api_key_vault_cmd = cat ${config.sops.secrets.wakatime.path}
    exclude_unknown_project = true
  '';
}
