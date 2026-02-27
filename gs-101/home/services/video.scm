(define-module (gs-101 home services video)
  #:use-module (gnu home services)
  #:use-module (gnu packages kde-multimedia)
  #:use-module (gnu packages video)
  #:use-module (gnu services)
  #:export (home-video-service-type))

(define (home-video-profile-service config)
  (list kdenlive
        obs))

(define home-video-service-type
  (service-type (name 'home-video)
                (description "Service containing packages specific to video
recording and editing.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-video-profile-service)))
                (default-value #f)))
