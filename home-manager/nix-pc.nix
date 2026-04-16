{ username, ... }:
{
  imports = [
    ./${username}.nix
    ./options/programs/niri.nix
  ];
}
