(define-module (gs-101 home services finance)
  #:use-module (gnu home services)
  #:use-module (gnu packages finance)
  #:use-module (gnu services)
  #:export (home-finance-service-type))

;; TODO: use cli instead.
(define (home-finance-profile-service config)
  (list monero-gui))

(define home-finance-service-type
  (service-type (name 'home-finance)
                (description "Service containing packages related to currency.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-finance-profile-service)))
                (default-value #f)))
