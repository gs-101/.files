(define-module (gs-101 home guix-pc)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gs-101 home base)
  #:use-module (gs-101 home services niri))

(home-environment
 (inherit base-home)
 (services (cons* (service home-niri-service-type)
                  base-home-services)))
