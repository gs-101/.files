{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    extraPackages = with pkgs; [ gamescope ];
    gamescopeSession.enable = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
  };
}
