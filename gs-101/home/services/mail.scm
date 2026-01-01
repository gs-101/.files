(define-module (gs-101 home services mail)
  #:use-module (gnu home services)
  ;; Home modules with "home-services" come form rde.
  #:use-module (gnu home-services mail)
  #:use-module (gnu home services mail)
  #:use-module (gnu packages mail)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (gs-101 utils)
  #:export (home-mail-services))

(define (home-mail-profile-service config)
  (list isync))

(define home-mail-service-type
  (service-type (name 'home-mail)
                (description "Service containing packages specific to a desktop
environment.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-mail-profile-service)))
                (default-value #f)))

(define home-mail-services
  (list (service home-isync-service-type
                 (home-isync-configuration
                  (config
                   `((IMAPAccount gabrielsantosdesouza@disroot.org)
                     (Host disroot.org)
                     (User gabrielsantosdesouza@disroot.org)
                     ;; TODO: Replace this with a gexp once home-isync-service-type is fixed.
                     (PassCmd "guix shell libsecret -- secret-tool lookup mail password")
                     (Port 993)
                     (TLSType IMAPS)
                     (AuthMechs LOGIN)
                     (TLSVersions -1.2)
                     (Timeout 120)
                     () ; This feels to hacky. :(
                     (IMAPStore gabrielsantosdesouza@disroot.org-remote)
                     (Account gabrielsantosdesouza@disroot.org)
                     () ; This feels to hacky. :(
                     (MaildirStore gabrielsantosdesouza@disroot.org-local)
                     (Path ~/Mail/gabrielsantosdesouza@disroot.org/)
                     (Inbox ~/Mail/gabrielsantosdesouza@disroot.org/Inbox/)
                     (Trash ~/Mail/gabrielsantosdesouza@disroot.org/Trash/)
                     (SubFolders Verbatim)
                     () ; This feels to hacky. :(
                     (Channel gabrielsantosdesouza@disroot.org)
                     (Far :gabrielsantosdesouza@disroot.org-remote:)
                     (Near :gabrielsantosdesouza@disroot.org-local:)
                     (Patterns "* !"Archive/*"")
                     (CopyArrivalDate yes)
                     (Sync All)
                     (Create Both)
                     (Expunge None)
                     (SyncState *)))))
        (service home-msmtp-service-type
                 (home-msmtp-configuration
                   (accounts
                    (list
                     (msmtp-account
                       (name "default")
                       (configuration
                        (msmtp-configuration
                          (host "disroot.org")
                          (port 465)
                          (user "gabrielsantosdesouza")
                          (password-eval
                           ;; secret-tool can be used with KeePassXC to
                           ;; comfortably get passwords for scripts.
                           ;; See:
                           ;; <https://redlib.freedit.eu/r/linux/comments/ehfhud/keyring_alternative_access_keepassxc_entries_of/>
                           #~(string-append #$(file-command* "libsecret" "secret-tool") "lookup mail password"))
                          (from "gabrielsantosdesouza@disroot.org"))))))
                   (defaults
                     (msmtp-configuration
                       (auth? #t)
                       (tls? #t)
                       (tls-starttls? #f)))))
        (service home-notmuch-service-type
                 (home-notmuch-configuration
                  (config
                   `((database
                      (("path" . "/home/gabriel/Mail/gabrielsantosdesouza@disroot.org")))
                     (user
                      (("primary_email" . "gabrielsantosdesouza@disroot.org")))))))))
