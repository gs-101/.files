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
    ./options/services/xserver.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  console.keyMap = "br-abnt2";
  programs.gpu-screen-recorder.enable = true;
  services.xserver.xkb.layout = "br";
  time.timeZone = "America/Sao_Paulo";
}
