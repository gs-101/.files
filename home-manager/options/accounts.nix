{ config, ... }:
{
  accounts.email = {
    accounts.disroot = {
      address = "gabrielsantosdesouza@disroot.org";
      gpg = {
        key = "1E7774E4262E0206";
        signByDefault = true;
      };
      imap.host = "disroot.org";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      notmuch.enable = true;
      primary = true;
      realName = "Gabriel Santos";
      passwordCommand = "pass show disroot.org/gabrielsantosdesouza | head -n 1";
      signature = {
        showSignature = "append";
        text = ''
          Gabriel Santos
        '';
      };
      smtp.host = "disroot.org";
      userName = "gabrielsantosdesouza@disroot.org";
    };
    maildirBasePath = "${config.xdg.dataHome}/mail";
  };
}
