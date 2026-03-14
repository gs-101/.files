{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    ignores = [
      "*-autoloads.el"
      "*-pkg.el"
      "*.elc"
    ];
    lfs.enable = true;
    package = pkgs.gitFull;
    settings = {
      github = {
        user = "gs-101";
      };
      init = {
        defaultBranch = "main";
      };
      sendemail = {
        annotate = true;
        sendmailCmd = "${pkgs.msmtp}/bin/msmtp";
      };
      signing = {
        key = "1E7774E4262E0206";
        signByDefault = true;
      };
      user = {
        email = "gabrielsantosdesouza@disroot.org";
        name = "Gabriel Santos";
      };
    };
  };
}
