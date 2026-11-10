{ lib, pkgs, ... }:
let
  mailNotify =
    pkgs.writers.writePython3Bin "mail_notify"
      {
        libraries = p: [ p.notmuch2 ];
        makeWrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          (lib.makeBinPath [ pkgs.libnotify ])
        ];
      }
      ''
        import email
        import email.policy
        import subprocess
        import notmuch2

        ICON_PATH = (
            "${pkgs.notmuch}"
            "/share/icons/hicolor/48x48/apps/notmuch.png"
        )

        with notmuch2.Database(mode=notmuch2.Database.MODE.READ_WRITE) as database:
            for message in database.messages("tag:new"):
                with open(message.path, "rb") as f:
                    email_message = email.message_from_binary_file(
                        f, policy=email.policy.default
                    )

                from_header = email_message["from"]
                if from_header and from_header.addresses:
                    addr = from_header.addresses[0]
                    sender = addr.display_name or addr.addr_spec
                else:
                    sender = "Unknown Sender"

                subject = email_message["subject"] or "(No Subject)"
                body = email_message.get_body(("plain",))
                preview = ""
                if body:
                    preview = " ".join(body.get_content().split())[:120]

                if preview:
                    notification = f"<b>{subject}</b>\n{preview}"
                else:
                    notification = f"<b>{subject}</b>"

                subprocess.run([
                    "notify-send",
                    "-a",
                    "Notmuch",
                    "-i",
                    ICON_PATH,
                    sender,
                    notification,
                ])

                message.tags.discard("new")
      '';
in
{
  programs.notmuch = {
    enable = true;
    hooks.postNew = "${lib.getExe mailNotify}";
    settings.new.tags = [
      "unread"
      "inbox"
      "new"
    ];
  };
}
