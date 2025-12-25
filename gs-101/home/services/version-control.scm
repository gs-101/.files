(define-module (gs-101 home services version-control)
  #:use-module (gnu home services)
  ;; Home modules with "home-services" come form rde.
  #:use-module (gnu home-services version-control)
  #:use-module (gnu packages version-control)
  #:use-module (gnu services)
  #:use-module (selected-guix-works packages rust-apps)
  #:use-module (gs-101 utils)
  #:export (home-version-control-services))

(define home-version-control-services
  (list (simple-service 'home-git-profile-service
                        home-profile-service-type
                        (list git
                              gitu))
        (service home-git-service-type
                 (home-git-configuration
                  (config
                   `((github
                      ((user . "gs-101")))
                     (init
                      ((defaultBranch . "main")))
                     (sendemail
                      ((annotate . #t)
                       (sendmailCmd . ,(file-command "msmtp"))))
                     (user
                      ((email . "gabrielsantosdesouza@disroot.org")
                       (name . "Gabriel Santos")))))
                  (ignore '("*.elc"
                            "*-autoloads.el"
                            "*-pkg.el"
                            "*.DS_Store"))))))
