(define-module (gs-101 home services terminals)
  #:use-module (gnu home services)
  #:use-module (gnu packages terminals)
  #:use-module (gnu services)
  #:export (home-terminals-service-type))

(define (home-terminals-profile-service config)
  (list alacritty))

(define (home-terminals-environment-variables-service config)
  '(("TERM" . "alacritty")))

(define home-terminals-service-type
  (service-type (name 'home-terminals)
                (description "Service containing configurations related to
terminal emulators.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-terminals-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-terminals-environment-variables-service)))
                (default-value #f)))
