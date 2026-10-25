{ pkgs, ... }:
{
  programs.antigravity-cli = {
    enable = true;
    settings.useG1Credits = true;
  };
}
