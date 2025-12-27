(define-module (gs-101 home services vim)
  #:use-module (gnu home services)
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:export (home-vim-service-type))

(define (home-vim-profile-service config)
  (list neovim))

(define (home-vim-environment-variables-service config)
  '(("EDITOR" . "TERM=alacritty-direct neovim")
    ("VISUAL" . "TERM=alacritty-direct neovim")))

(define home-vim-service-type
  (service-type (name 'home-vim)
                (description "Service containing configurations related to Vim.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-vim-profile-service)
                       ;; (service-extension
                       ;;  home-environment-variables-service-type
                       ;;  home-vim-environment-variables-service)
                       ))
                (default-value #f)))
