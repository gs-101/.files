(define-module (gs-101 home services mail)
  #:use-module (gnu home services)
  #:use-module (gnu home services mail)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (gs-101 utils)
  #:export (home-mail-services))

(define home-mail-services
  (list (service home-msmtp-service-type
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
                           #~(string-append #$(file-command* "libsecret" "secret-tool") "lookup msmtp password"))
                          (from "gabrielsantosdesouza@disroot.org"))))))
                   (defaults
                     (msmtp-configuration
                       (auth? #t)
                       (tls? #t)
                       (tls-starttls? #f)))))))
