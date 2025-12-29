(define-module (gs-101 home services shellutils)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cryptsetup)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (selected-guix-works home services rust-apps)
  #:export (home-shellutils-services))

(define (home-shellutils-profile-service config)
  (list bat
        cryptsetup
        direnv
        eza
        fd
        pay-respects
        starship
        unzip))

(define (home-shellutils-environment-variables-service config)
  '(("STARSHIP_CONFIG" . "$XDG_CONFIG_HOME/starship/starship.toml")))

(define home-shellutils-service-type
  (service-type (name 'home-shellutils)
                (description "Service containing useful terminal applications.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-shellutils-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-shellutils-environment-variables-service)))
                (default-value #f)))

(define home-shellutils-services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (aliases
                   '(("grep" . "grep --extended-regexp --ignore-case --line-number  --with-filename --quiet -R --devices=read --color=auto")
                     (".." . "cd ..")
                     ("bat" . "bat --color auto --decorations auto --paging never --theme=base16-256")
                     ("eza" . "eza --long --dereference --color auto --icons auto --hyperlink --all --group-directories-first --smart-group --header --changed --git")
                     ("ip" . "ip -color=auto")
                     ("df" . "df --human-readable")
                     ("free" . "free --mebi --human")
                     ("fd" . "fd --follow --hyperlink=auto")))
                  (bash-profile
                   (list (local-file "files/bash_profile")))
                  (bashrc
                   (list (local-file "files/bashrc")))
                  (environment-variables
                   '(("HISTCONTROL" . "ignoredups:erasedups")
                     ("HISTFILE" . "$XDG_CACHE_HOME/.bash_history")))))
        (service home-shellutils-service-type)
        (service home-ripgrep-service-type
                 (home-ripgrep-configuration
                  (search-zip? #t)
                  ;; Search case-insensitively when all text is lowercase.
                  (smart-case? #t)
                  ;; Follow symbolic links. Useful in this "software in a store" model.
                  (follow? #t)
                  ;; Automatically switch to Perl Compatible Regular Expressions
                  ;; if functionality specific to them is used.
                  (engine "auto")
                  ;; Enable hyperlinks on output.
                  (hyperlink-format "default")))
        (service home-inputrc-service-type
                 (home-inputrc-configuration
                  (variables
                   `(("colored-stats" . #t)
                     ("colored-completion-prefix" . #t)
                     ("editing-mode" . "emacs")
                     ;; Complete AND show other additional completion
                     ;; options with a single tab press.
                     ("show-all-if-ambiguous" . #t)
                     ;; With colours enabled, this colours the
                     ;; prefix in menu-complete.
                     ("menu-complete-display-prefix" . #t)))))))
