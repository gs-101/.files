{ config, ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoreboth"
    ];
    historyFile = "${config.xdg.dataHome}/bash/history";
    shellAliases = {
      ".." = "cd ..";
      "df" = "df -h";
      "free" = "free -hm";
      "ls" = "ls -ahHl --author --group-directories-first --hyperlink=auto";
      "lsblk" = "lsblk -f";
    };
    shellOptions = [
      "globstar"
      "histappend"
    ];
  };
}
