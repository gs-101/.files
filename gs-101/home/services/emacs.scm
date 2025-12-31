(define-module (gs-101 home services emacs)
  #:use-module (emacs-master)
  #:use-module (gnu home services)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages emacs)
  #:use-module (gnu services)
  #:export (home-emacs-service-type))

(define (home-emacs-profile-service config)
  (list emacs-master-pgtk-igc))

(define (home-emacs-environment-variables-service config)
  '(("EDITOR" . "emacsclient --create-frame --no-window-system --alternate-editor=''")
    ("VISUAL" . "emacsclient --create-frame --alternate-editor=''")))

(define (home-emacs-xdg-mime-applications-service config)
  (home-xdg-mime-applications-configuration
    (default
      '((inode/directory . emacsclient.desktop)
        (x-scheme-handler/mailto . emacsclient-mail.desktop)))))

(define home-emacs-service-type
  (service-type (name 'home-emacs)
                (description "Service containing configurations related to Emacs.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-emacs-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-emacs-environment-variables-service)
                       (service-extension
                        home-xdg-mime-applications-service-type
                        home-emacs-xdg-mime-applications-service)))
                (default-value #f)))
