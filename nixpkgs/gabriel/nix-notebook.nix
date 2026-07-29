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
  programs.gpu-screen-recorder.enable = true;
  time.timeZone = "America/Sao_Paulo";
}
