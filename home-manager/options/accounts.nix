{ config, ... }:
{
  imports = [
    ./sops.nix
  ];
  accounts.email = {
    accounts.disroot = {
      address = "gabrielsantosdesouza@disroot.org";
      imap.host = "disroot.org";
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
      primary = true;
      realName = "Gabriel Santos";
      passwordCommand = "cat ${config.sops.secrets.disroot.path}";
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
