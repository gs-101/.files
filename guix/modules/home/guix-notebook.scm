(define-module (home guix-notebook)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (home base))

(home-environment
 (inherit base-home)
 (packages (cons* (specifications->packages '("brightnessctl"
                                              "hypridle"
                                              "hyprlock"))
                  %base-home-packages))
 (services (cons* (simple-service 'home-hypridle-configuration-service
                                  home-xdg-configuration-files-service-type
                                  (list `("hypr/hypridle.conf"
                                          ,(dotfiles-file "hypr/hypridle.conf"))))
                  (simple-service 'home-hyprlock-configuration-service
                                  home-xdg-configuration-files-service-type
                                  (list `("hypr/hyprlock.conf"
                                          ,(dotfiles-file "hypr/hyprlock.conf"))))
                  %base-home-services)))
