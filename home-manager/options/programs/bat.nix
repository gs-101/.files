{ pkgs, ... }:
{
  home.sessionVariables = {
    PAGER = "${pkgs.bat}/bin/bat --paging=always";
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "noctalia";
    };
  };
}
