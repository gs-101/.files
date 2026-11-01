{
  home.shellAliases.ls = "eza";
  programs.eza = {
    enable = true;
    extraOptions = [
      "--all"
      "--classify=auto"
      "--git-ignore"
      "--group-directories-first"
      "--hyperlink"
      "--short-nix"
    ];
    icons = "auto";
  };
}
