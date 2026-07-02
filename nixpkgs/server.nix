{ ... }:
{
  imports = [
    ./general.nix
    ./options/nix/gc.nix
  ];
  hardware.pulseaudio.enable = false;
}
