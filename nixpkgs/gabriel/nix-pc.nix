{
  pkgs,
  ...
}:
{
  imports = [
    ./default.nix
    ./options/networking.nix
    ./options/hardware/graphics.nix
    ./options/services/btrbk.nix
    ./options/services/pipewire.nix
    ./options/services/xmrig.nix
    ./options/services/xserver.nix
    ./options/virtualisation.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  console.keyMap = "br-abnt2";
  services.xserver.xkb.layout = "br";
  time.timeZone = "America/Sao_Paulo";
}
