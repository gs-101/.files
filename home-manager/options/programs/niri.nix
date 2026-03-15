{ ... }:
{
  programs.niri = {
    # TODO: migrate to settings after the include statement is added.
    enable = true;
  };
  xdg.configFile."niri/config.kdl".text = builtins.readFile ./niri.kdl;
}
