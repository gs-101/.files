{
  config,
  lib,
  pkgs,
  ...
}:
let
  ssh-key = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
in
{
  home.packages = [ pkgs.git-toolbelt ];
  programs.git = {
    enable = true;
    ignores = [
      "*-autoloads.el"
      "*-pkg.el"
      "*.elc"
      ".direnv/"
    ];
    lfs.enable = true;
    package = pkgs.gitFull;
    settings = {
      # TODO: discover if this is really necessary.
      core = {
        sshCommand = "ssh -i ${ssh-key} -o IdentitiesOnly=yes";
      };
      github = {
        user = "gs-101";
      };
      init = {
        defaultBranch = "main";
      };
      sendemail = {
        annotate = true;
        sendmailCmd = "${lib.getExe pkgs.msmtp}";
      };
      user = {
        email = "gabrielsantosdesouza@disroot.org";
        name = "Gabriel Santos";
      };
    };
    signing = {
      format = "ssh";
      key = "${ssh-key}.pub";
      signByDefault = true;
    };
  };
}
