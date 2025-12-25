(define-module (gs-101 home services image)
  #:use-module (gnu home services)
  #:use-module (gnu packages gimp)
  #:use-module (gnu packages inkscape)
  #:use-module (gnu services)
  #:export (home-image-service-type))

(define (home-image-profile-service config)
  (list gimp
        inkscape))

(define home-image-service-type
  (service-type (name 'home-image)
                (description "Service containing packages specific to image
editing.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-image-profile-service)))
                (default-value #f)))
