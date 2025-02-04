{ ... }:
{
  accounts.email.accounts = {
    disroot = {
      address = "gabrielsantosdesouza@disroot.org";
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
        text = ''
          Gabriel Santos
        '';
      };
      smtp = {
        host = "disroot.org";
      };
      userName = "gabrielsantosdesouza@disroot.org";
    };
  };
}
