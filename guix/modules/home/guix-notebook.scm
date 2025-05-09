(define-module (home guix-notebook)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (home base))

(define notebook-packages '("hypridle"
                            "hyprlock"))

(home-environment
  (inherit base-home)
  (packages (specifications->packages (append (notebook-packages %base-home-packages))))
  (services (cons* (simple-service 'home-hypridle-configuration-service
                                   home-xdg-configuration-files-service-type
                                   (list `("hypr/hypridle.conf"
                                           ,(dotfiles-file "hypr/hypridle.conf"))))
                   (simple-service 'home-hyprlock-configuration-service
                                   home-xdg-configuration-files-service-type
                                   (list `("hypr/hyprlock.conf"
                                           ,(dotfiles-file "hypr/hyprlock.conf"))))
                   %base-home-services)))
