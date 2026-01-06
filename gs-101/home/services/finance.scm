(define-module (gs-101 home services finance)
  #:use-module (gnu home services)
  #:use-module (gnu packages finance)
  #:use-module (gnu services)
  #:export (home-finance-service-type))

(define (home-finance-profile-service config)
  (list monero))

(define home-finance-service-type
  (service-type (name 'home-finance)
                (description "Service containing packages related to currency.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-finance-profile-service)))
                (default-value #f)))
