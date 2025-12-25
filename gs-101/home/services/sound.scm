(define-module (gs-101 home services sound)
  #:use-module (gnu home services)
  #:use-module (gnu home services sound)
  #:export (home-sound-services))

(define home-sound-services
  (list (service home-pipewire-service-type)))
