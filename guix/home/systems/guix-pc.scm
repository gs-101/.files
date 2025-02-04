(use-modules (gnu home)
             (gnu home services)
             (gnu packages)
             (gnu packages gnupg)
             (gnu services)
             (guix gexp)
             (gnu home services shells)
             (gnu home services gnupg))

(home-environment
 (services
  (let ((DOTFILES ".files/"))
    (cons* (simple-service 'home-variables-service
                           home-environment-variables-service-type
                           `(("DOTFILES" . "$HOME/.files")))
           (service home-bash-service-type
                    (home-bash-configuration
                     (aliases '(("grep" . "grep --color=auto")
                                (".." . "cd ..")
                                ("cat" . "bat --color auto --decorations auto --paging never")
                                ("ls" . "eza -l -X --color auto --icons auto --hyperlink -a --group-directories-first --smart-group -h --changed --git")
                                ("ip" . "ip -color=auto")
                                ("df" . "df -H")
                                ("free" . "free -m -h --si")))
                     (bashrc (list (local-file (string-append DOTFILES "bash/.bashrc")
                                               "bashrc")))
                     (bash-profile (list (local-file (string-append DOTFILES "bash/.bash_profile")
                                                     "bash_profile")))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration
                     (pinentry-program
                      (file-append pinentry-emacs "/bin/pinentry-emacs"))
                     (ssh-support? #t)))
           (simple-service 'home-nix-service
                           home-xdg-configuration-files-service-type
                           (list `("nix/nix.conf"
                                   ,(plain-file "nix.conf"
                                                "experimental-features = nix-command flakes"))))
           (simple-service 'home-nix-home-manager-service
                           home-xdg-configuration-files-service-type
                           (list `("home-manager"
                                   ,(local-file (string-append DOTFILES "nix/home/")
                                                "home-manager"
                                                #:recursive? #t))))
           (simple-service 'home-makefile-service
                           home-files-service-type
                           (list `("Makefile"
                                   ,(local-file (string-append DOTFILES "Makefile")
                                                "Makefile"))))
           (simple-service 'home-gitignore-service
                           home-files-service-type
                           (list `(".gitignore"
                                   ,(plain-file "gitignore" "*.elc
*-autoloads.el
*-pkg.el
*.DS_Store"))))
           (simple-service 'home-wakatime-service
                           home-files-service-type
                           (list `(".wakatime.cfg"
                                   ,(local-file (string-append DOTFILES "wakatime/.wakatime.cfg")
                                                "wakatime.cfg"))))
           (simple-service 'home-emacs-master-pgtk-service
                           home-profile-service-type
                           (list (specification->package "emacs-master-pgtk")))
           (simple-service 'home-password-store-service
                           home-profile-service-type
                           (list (specification->package "password-store")))
           (simple-service 'home-bat-service
                           home-profile-service-type
                           (list (specification->package "bat")))
           (simple-service 'home-eza-service
                           home-profile-service-type
                           (list (specification->package "eza")))
           (simple-service 'home-ripgrep-service
                           home-profile-service-type
                           (list (specification->package "ripgrep")))
           (simple-service 'home-font-fira-code-service
                           home-profile-service-type
                           (list (specification->package "font-fira-code")))
           (simple-service 'home-rofi-service
                           home-profile-service-type
                           (list (specification->package "rofi")))
           (simple-service 'home-kitty-service
                           home-profile-service-type
                           (list (specification->package "kitty")))
           (simple-service 'home-librewolf-service
                           home-profile-service-type
                           (list (specification->package "librewolf")))
           (simple-service 'home-gpg-service
                           home-profile-service-type
                           (list (specification->package "gnupg")))
           (simple-service 'home-make-service
                           home-profile-service-type
                           (list (specification->package "make")))
           (simple-service 'home-hyprland-service
                           home-profile-service-type
                           (list (specification->package "hyprland")))
           %base-home-services))))
