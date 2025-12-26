(define-module (gs-101 home base)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services syncthing)
  ;; TODO: Delete this.
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gs-101 home services desktop)
  #:use-module (gs-101 home services emacs)
  #:use-module (gs-101 home services fonts)
  #:use-module (gs-101 home services gnupg)
  #:use-module (gs-101 home services hyprland)
  #:use-module (gs-101 home services image)
  #:use-module (gs-101 home services mail)
  #:use-module (gs-101 home services shellutils)
  #:use-module (gs-101 home services sound)
  #:use-module (gs-101 home services terminals)
  #:use-module (gs-101 home services version-control)
  #:use-module (gs-101 home services video)
  #:use-module (gs-101 home services vim)
  #:use-module (gs-101 home services wayland)
  #:export (base-home
            base-home-packages
            base-home-services))

;; TODO: Delete this.
(define base-home-packages
  '("keepassxc"
    "zotero"))

;; TODO: I think that having the services in a bunch of lists like this looks
;; nice.
(define base-home-services
  (append (list (service home-dotfiles-service-type
                         (home-dotfiles-configuration
                          (directories '("../../plain"))
                          (excluded '(".envrc"))))
                (service home-emacs-service-type)
                (service home-syncthing-service-type
                         (for-home
                          (syncthing-configuration
                           (user "gabriel"))))
                (service home-hyprland-service-type)
                (service home-image-service-type)
                (service home-terminals-service-type)
                (service home-video-service-type)
                (service home-vim-service-type)
                (service home-wayland-service-type))
          home-desktop-services
          home-fonts-services
          home-version-control-services
          home-gnupg-services
          home-mail-services
          home-shellutils-services
          home-sound-services))

(define base-home
  (home-environment
    (packages (specifications->packages base-home-packages))
    (services base-home-services)))

base-home
