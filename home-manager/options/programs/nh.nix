{ dotfiles, ... }:
{
  programs.nh = {
    enable = true;
    flake = dotfiles;
  };
}
