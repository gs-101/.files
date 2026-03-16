{ host, ... }:
{
  imports = [
    ./base.nix
    ./options/disko/${host}.nix
  ];
  console.keyMap = "br";
  networking.hostName = host;
  services = {
    xserver = {
      enable = true;
      xkb.layout = "br";
    };
  };
  time.timeZone = "America/Sao_Paulo";
}
