{
  config,
  pkgs,
  ...
}:
{
  accounts.email = {
    accounts = {
      disroot = {
        address = "gabrielsantosdesouza@disroot.org";
        imap.host = "disroot.org";
        imapnotify = {
          enable = true;
          onNotify = "mbsync disroot";
          onNotifyPost = "notmuch new";
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
          extraConfig.channel = {
            Sync = "All";
          };
        };
        msmtp.enable = true;
        notmuch.enable = true;
        primary = false;
        realName = "Gabriel Santos";
        passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.disroot.path}";
        smtp.host = "disroot.org";
        userName = "gabrielsantosdesouza@disroot.org";
      };
      purelymail = {
        address = "me@gs-101.dev";
        aliases = [
          "acme@gs-101.dev"
          "contact@gs-101.dev"
          "emacs-devel@gs-101.dev"
          "git@gs-101.dev"
        ];
        imap.host = "imap.purelymail.com";
        imapnotify = {
          enable = true;
          onNotify = "mbsync purelymail";
          onNotifyPost = "notmuch new";
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
          extraConfig.channel = {
            Sync = "All";
          };
        };
        msmtp.enable = true;
        notmuch.enable = true;
        signature = {
          showSignature = "append";
          text = ''
            Gabriel Santos <https://gs-101.dev>
          '';
        };
        smtp.host = "smtp.purelymail.com";
        userName = "gs101@purelymail.com";
        passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.purelymail.path}";
        realName = "Gabriel Santos";
        primary = true;
      };
    };
  };
  sops.secrets = {
    disroot = { };
    purelymail = { };
  };
}
