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
    ./options/virtualisation.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  console.keyMap = "br-abnt2";
  services = {
    btrbk.instances.disk.settings.volume."/btrfs".subvolume = {
      home = { };
      root = { };
    };
    restic.backups.google-drive.paths = [ "/home" ];
    xserver.xkb.layout = "br";
  };
  time.timeZone = "America/Sao_Paulo";
}
