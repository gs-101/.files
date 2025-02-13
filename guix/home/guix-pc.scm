(use-modules (gnu home)
             (gnu home services)
             (gnu packages)
             (gnu packages gnupg)
             (gnu services)
             (guix gexp)
             (gnu home services shells)
             (gnu home services gnupg)
             (gnu home services syncthing)
             (gnu home services sound)
             (gnu home services desktop))

(home-environment
 (services
  (let ((DOTFILES ".files/"))
    (cons* (simple-service 'home-variables-service
                           home-environment-variables-service-type
                           `(("DOTFILES" . "$HOME/.files")
                             ("TERM" . "kitty")
                             ("EDITOR" . "emacs -nw")
                             ("VISUAL" . "emacs")
                             ("SHELL" . "bash")
                             ("BROWSER" . "librewolf")
                             ("FILE_MANAGER" . "tv")
                             ("BAR" . "waybar")
                             ("MENU" . "fuzzel")))
           (service home-bash-service-type
                    (home-bash-configuration
                     (aliases '(("grep" . "grep --color=auto")
                                (".." . "cd ..")
                                ("cat" . "bat --color auto --decorations auto --paging never")
                                ("ls" . "eza -l -X --color auto --icons auto --hyperlink -a --group-directories-first --smart-group -h --changed --git")
                                ("ip" . "ip -color=auto")
                                ("df" . "df -H")
                                ("free" . "free -m -h --si")
                                ("docker" . "podman")))
                     (bashrc (list (local-file (string-append DOTFILES "bash/.bashrc")
                                               "bashrc")))
                     (bash-profile (list (local-file (string-append DOTFILES "bash/.bash_profile")
                                                     "bash_profile")))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration
                     (pinentry-program
                      (file-append pinentry-emacs "/bin/pinentry-emacs"))
                     (ssh-support? #t)))
           (service home-syncthing-service-type
                    (for-home
                     (syncthing-configuration
                      (user "gabriel"))))
           (service home-dbus-service-type)
           (service home-pipewire-service-type)
           (simple-service 'home-nix-configuration-service
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
           (simple-service 'home-neovim-service
                           home-profile-service-type
                           (list (specification->package "neovim")))
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
           (simple-service 'home-font-microsoft-cascadia-next-service
                           home-profile-service-type
                           (list (specification->package "font-microsoft-cascadia-next")))
           (simple-service 'home-fuzzel-service
                           home-profile-service-type
                           (list (specification->package "fuzzel")))
           (simple-service 'home-kitty-service
                           home-profile-service-type
                           (list (specification->package "kitty")))
           (simple-service 'home-librewolf-service
                           home-profile-service-type
                           (list (specification->package "librewolf")))
           (simple-service 'home-gpg-service
                           home-profile-service-type
                           (list (specification->package "gnupg")))
           (simple-service 'home-hyprland-service
                           home-profile-service-type
                           (list (specification->package "hyprland")))
           (simple-service 'home-hyprland-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("hypr/hyprland.conf"
                                   ,(local-file (string-append DOTFILES "hypr/hyprland.conf")
                                                "hyprland.conf"))))
           (simple-service 'home-fnott-service
                           home-profile-service-type
                           (list (specification->package "fnott")))
           (simple-service 'home-polkit-kde-agent-service
                           home-profile-service-type
                           (list (specification->package "polkit-kde-agent")))
           (simple-service 'home-waybar-service
                           home-profile-service-type
                           (list (specification->package "waybar")))
           (simple-service 'home-make-service
                           home-profile-service-type
                           (list (specification->package "make")))
           (simple-service 'home-mpv-service
                           home-profile-service-type
                           (list (specification->package "mpv")))
           (simple-service 'home-hyprpicker-service
                           home-profile-service-type
                           (list (specification->package "hyprpicker")))
           (simple-service 'home-dolphin-service
                           home-profile-service-type
                           (list (specification->package "dolphin")))
           (simple-service 'home-selected-guix-works-backgrounds-service
                           home-profile-service-type
                           (list (specification->package "selected-guix-works-backgrounds")))
           (simple-service 'home-hyprpaper-service
                           home-profile-service-type
                           (list (specification->package "hyprpaper")))
           (simple-service 'home-hyprpaper-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("hypr/hyprpaper.conf"
                                   ,(plain-file "hyprpaper.conf"
                                                "
preload = /home/gabriel/.guix-home/profile/share/backgrounds/selected-guix-works/guix/guix-nix-checkered-16-9.png
wallpaper = , /home/gabriel/.guix-home/profile/share/backgrounds/selected-guix-works/guix/guix-nix-checkered-16-9.png
"))))
           (simple-service 'home-clipman-service
                           home-profile-service-type
                           (list (specification->package "clipman")))
           (simple-service 'home-udiskie-service
                           home-profile-service-type
                           (list (specification->package "udiskie")))
           %base-home-services))))
