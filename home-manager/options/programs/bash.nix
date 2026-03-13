{ ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoreboth"
    ];
    shellAliases = {
      ".." = "cd ..";
      "df" = "df -h";
      "free" = "free -hm";
      "ls" = "ls -ahHl --author --group-directories-first --hyperlink=auto";
      "lsblk" = "lsblk -f";
      "mount" = "mount -m";
    };
    shellOptions = [
      "globstar"
      "histappend"
    ];
  };
}
