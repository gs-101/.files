{
  pkgs,
  ...
}:
{
  imports = [
    ./default.nix
    ./options/networking.nix
    ./options/hardware/graphics.nix
    ./options/programs/steam.nix
    ./options/services/btrbk.nix
    ./options/services/pipewire.nix
    ./options/services/xserver.nix
    ./options/virtualisation.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "America/Sao_Paulo";
}
