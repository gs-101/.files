(define-module (gs-101 home guix-pc)
  #:use-module (gnu home)
  #:use-module (gnu home services niri)
  #:use-module (gnu services)
  #:use-module (gs-101 home base))

(home-environment
 (inherit base-home)
 (services (cons* (service home-niri-service-type)
                  base-home-services)))
