(define-module (gs-101 home services gnupg)
  #:use-module (gnu home services)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages ssh)
  #:use-module (gnu services)
  #:use-module (gs-101 utils)
  #:export (home-gnupg-services))

(define (home-gnupg-profile-service config)
  (list gnupg
        openssh))

(define (home-gnupg-environment-variables-service config)
  '(("GPG_TTY" . "$(tty)")))

(define home-gnupg-service-type
  (service-type (name 'home-gnupg)
                (description "Service containing configurations for gpg.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-gnupg-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-gnupg-environment-variables-service)))
                (default-value #f)))

(define home-gnupg-services
  (list (service home-gnupg-service-type)
        (service home-gpg-agent-service-type
                 (home-gpg-agent-configuration
                   (pinentry-program
                    (file-command "pinentry-qt"))
                   (ssh-support? #t)))))
