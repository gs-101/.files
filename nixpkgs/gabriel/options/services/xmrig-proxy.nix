{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.xmrig-proxy;
  json = pkgs.formats.json { };
  configFile = json.generate "xmrig-proxy.json" cfg.settings;
in
{
  options.services.xmrig-proxy = {
    enable = lib.mkEnableOption "XMRig Stratum Proxy";

    package = lib.mkPackageOption pkgs "xmrig-proxy" { };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to automatically open the proxy port in the firewall.";
    };

    settings = lib.mkOption {
      type = json.type;
      default = { };
      description = ''
        XMRig Proxy configuration. Refer to
        <https://github.com/xmrig/xmrig-proxy>
        for details on supported values.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ 3333 ];

    systemd.services.xmrig-proxy = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "XMRig Stratum Proxy Service";
      serviceConfig = {
        ExecStart = "${lib.getExe cfg.package} --config=${configFile}";
        DynamicUser = true;
        Restart = "always";
        RestartSec = "10s";
      };
    };

    systemd.services.xmrig = lib.mkIf config.services.xmrig.enable {
      after = [ "xmrig-proxy.service" ];
      wants = [ "xmrig-proxy.service" ];
    };
  };
}
