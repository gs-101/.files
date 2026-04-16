{ username, ... }:
{
  imports = [
    ./${username}.nix
    ./options/programs/hyprland.nix
  ];
}
