# TODO: Replace with crowdsec.
# See: https://github.com/NixOS/nixpkgs/pull/535319
# TODO: Also consider reaction.
# See: https://reaction.ppom.me/

{
  services.fail2ban = {
    enable = true;
    bantime-increment.enable = true;
    ignoreIP = [ "192.168.0.0/16" ];
  };
}
