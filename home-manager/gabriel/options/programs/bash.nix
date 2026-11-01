{
  home.shell.enableBashIntegration = true;
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
      "lsblk" = "lsblk -f";
    };
    shellOptions = [
      "globstar"
      "histappend"
    ];
  };
}
