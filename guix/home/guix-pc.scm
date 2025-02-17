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
             (gnu home services desktop)
             (gnu home services fontutils)
             (selected-guix-works utils))

(home-environment
 (services
  (let ((DOTFILES ".files/"))
    (cons* (simple-service 'home-variables-service
                           home-environment-variables-service-type
                           `(("DOTFILES" . "$HOME/.files")
                             ("TERM" . "kitty")
                             ("EDITOR" . "emacsclient -nw -a 'emacs -nw'")
                             ("VISUAL" . "emacsclient --create-frame -a 'emacs'")
                             ("SHELL" . "bash")
                             ("BROWSER" . "librewolf")
                             ("FILE_MANAGER" . "tv")
                             ("BAR" . "waybar")
                             ("MENU" . "fuzzel")))
           (service home-bash-service-type
                    (home-bash-configuration
                     (environment-variables '(("HISTCONTROL" . "ignoredups:erasedups")))
                     (aliases '(("grep" . "grep --color=auto")
                                (".." . "cd ..")
                                ("cat" . "bat --color auto --decorations auto --paging never")
                                ("ls" . "eza -l -X --color auto --icons auto --hyperlink -a --group-directories-first --smart-group -h --changed --git")
                                ("ip" . "ip -color=auto")
                                ("df" . "df -H")
                                ("free" . "free -m -h --si")
                                ("docker" . "podman")))
                     (bash-profile (list (local-file (string-append DOTFILES "bash/.bash_profile")
                                                     "bash_profile")))))
           (simple-service 'home-bash-extension-service
                           home-bash-service-type
                           (home-bash-extension
                            (bash-profile (list (plain-file "bash_profile"
                                                            "
# Set up Nix profile.
source /run/current-system/profile/etc/profile.d/nix.sh

# Keep Home Manager out of shell configuration.
if [ -f ~/.nix-profile/bin/home-manager ]; then source ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi
")))
                            (bashrc (list (plain-file "bashrc"
                                                      "
# gpg-agent frustratingly doesn't seem to update on startup.
# This restarts it so SSH keys can be used.
gpg-connect-agent updatestartuptty /bye >/dev/null

# Save commands in history on a single line.
shopt -s cmdhist
# Do not overwrite history.
shopt -s histappend
# Recursive globbing.
shopt -s globstar
")))))
           (service home-inputrc-service-type
                    (home-inputrc-configuration
                     (variables
                      '(("editing-mode" . "emacs")))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration
                     (pinentry-program
                      (file-append pinentry-emacs "/bin/pinentry-emacs"))
                     (ssh-support? #t)))
           (home-profile-package-service "font-microsoft-cascadia-next")
           (home-profile-package-service "font-google-noto-emoji")
           (home-profile-package-service "font-aporetic")
           (simple-service 'home-fontconfig-service
                           home-fontconfig-service-type
                           (list "~/.guix-home/profile/share/fonts/"
                                 '(alias
                                   (family "monospace")
                                   (prefer
                                    (family "Cascadia Mono NF")))
                                 '(alias
                                   (family "serif")
                                   (prefer
                                    (family "Aporetic Serif")))
                                 '(alias
                                   (family "sans-serif")
                                   (prefer
                                    (family "Cascadia Code NF")))
                                 '(alias
                                   (family "emoji")
                                   (prefer
                                    (family "Noto Color Emoji")))))
           (simple-service 'home-openssh-service
                           home-profile-service-type
                           (list (specification->package "openssh")))
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
           (home-profile-package-service "emacs-master-pgtk")
           (home-profile-package-service "neovim")
           (home-profile-package-service "password-store")
           (home-profile-package-service "bat")
           (home-profile-package-service "eza")
           (home-profile-package-service "ripgrep")
           (home-profile-package-service "fuzzel")
           (home-profile-package-service "kitty")
           (home-profile-package-service "librewolf")
           (home-profile-package-service "gnupg")
           (home-profile-package-service '("hyprland"
                                           "xdg-desktop-portal-hyprland"
                                           "hyprpolkitagent"
                                           "hyprpicker"
                                           "hyprpaper"
                                           ;; For hyprshot
                                           "slurp"
                                           "grim"
                                           "libnotify"
                                           "hyprshot"))
           (home-profile-package-service "selected-guix-works-backgrounds")
           (simple-service 'home-hyprpaper-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("hypr/hyprpaper.conf"
                                   ,(plain-file "hyprpaper.conf"
                                                "
preload = /home/gabriel/.guix-home/profile/share/backgrounds/selected-guix-works/guix/guix-nix-checkered-16-9.png
wallpaper = , /home/gabriel/.guix-home/profile/share/backgrounds/selected-guix-works/guix/guix-nix-checkered-16-9.png
"))))
           (simple-service 'home-hyprland-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("hypr/hyprland.conf"
                                   ,(local-file (string-append DOTFILES "hypr/hyprland.conf")
                                                "hyprland.conf"))))
           (home-profile-package-service "fnott")
           (home-profile-package-service "waybar")
           (home-profile-package-service "make")
           (home-profile-package-service "mpv")
           (home-profile-package-service "dolphin")
           (home-profile-package-service '("wl-clipboard"
                                           "clipman"))
           (home-profile-package-service "udiskie")
           (home-profile-package-service "bibata-cursor-theme")
           %base-home-services))))
