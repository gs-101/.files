(define-module (gs-101 home services wayland)
  #:use-module (gnu home services)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu services)
  #:export (home-wayland-service-type))

(define (home-wayland-profile-service config)
  (list cliphist
        wl-clipboard))

(define home-wayland-service-type
  (service-type (name 'home-wayland)
                (description "Service containing packages that are helpful for
a Wayland environment.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-wayland-profile-service)))
                (default-value #f)))
