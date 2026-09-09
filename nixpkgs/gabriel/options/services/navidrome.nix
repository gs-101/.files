{ pkgs, ... }:
{
  services.navidrome = {
    enable = true;
    plugins = with pkgs; [
      navidrome-lyrics-plugin
    ];
    settings = {
      EnableInsightsCollector = true;
      LyricsPriority = "nd-lyrics,embedded,.lrc,.txt";
    };
  };
}
