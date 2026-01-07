(define-module (gs-101 home guix-notebook)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gs-101 home base)
  #:use-module (gs-101 home services hyprland))

(home-environment
 (inherit base-home)
 (services (cons* (service home-hyprland-service-type)
                  base-home-services)))
