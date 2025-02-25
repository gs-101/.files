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
    ;; HACK: This is used to make local-file find files relative to the current
    ;; directory, which in a regular shell would be $HOME.
    ;; Without this, local-file always tries to find files relative to its origin
    ;; file, so, for example, in bash-profile it would look for the profile under
    ;; .files/guix/home/.bash_profile
    (cons* (simple-service 'home-variables-service
                           home-environment-variables-service-type
                           `(("DOTFILES" . "$HOME/.files")
                             ("TERM" . "alacritty")
                             ("TERMINAL" . "alacritty")
                             ("EDITOR" . "emacsclient -nw -a 'emacs -nw'")
                             ("VISUAL" . "emacsclient --create-frame -a 'emacs'")
                             ("SHELL" . "bash")
                             ("BROWSER" . "librewolf")
                             ("BAR" . "waybar")
                             ("MENU" . "fuzzel")
                             ("RIPGREP_CONFIG_PATH" . "$XDG_CONFIG_HOME/ripgrep/ripgrep.conf")
                             ("HYPRSHOT_DIR" . "$HOME/Pictures/screenshots")))
           (service home-bash-service-type
                    (home-bash-configuration
                     (environment-variables '(("HISTCONTROL" . "ignoredups:erasedups")))
                     (aliases '(("grep" . "grep -P -i -n -H -q -R --devices=read --color=auto")
                                (".." . "cd ..")
                                ("bat" . "bat --color auto --decorations auto --paging never")
                                ("eza" . "eza -l -X --color auto --icons auto --hyperlink -a --group-directories-first --smart-group -h --changed --git")
                                ("ip" . "ip -color=auto")
                                ("df" . "df -H")
                                ("free" . "free -m -h --si")
                                ("docker" . "podman")
                                ("fd" . "fd --follow --hyperlink=auto")))
                     (bashrc (list (local-file (string-append DOTFILES "bash/.bashrc")
                                               "bashrc")))
                     (bash-profile (list (local-file (string-append DOTFILES "bash/.bash_profile")
                                                     "bash_profile")))))
           (service home-inputrc-service-type
                    (home-inputrc-configuration
                     (variables
                      '(("editing-mode" . "emacs")))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration
                     (pinentry-program
                      (file-append pinentry-qt "/bin/pinentry-qt"))
                     (ssh-support? #t)))
           (home-profile-package-service "font-microsoft-cascadia")
           (home-profile-package-service "font-google-noto-emoji")
           (home-profile-package-service "font-aporetic")
           (simple-service 'home-fontconfig-service
                           home-fontconfig-service-type
                           ;; Includes suggestions from
                           ;; https://fontconfig.pages.freedesktop.org/fontconfig/fontconfig-user.html
                           (list
                            ;; Alias deprecated mono to monospace
                            '(match (@ (target "pattern"))
                               (test (@ (qual "any") (name "family"))
                                     (string "mono"))
                               (edit (@ (name "family") (mode "assign"))
                                     (string "monospace")))
                            ;; Not recognized aliases default to the sans-serif font
                            '(match (@ (target "pattern"))
                               (test (@ (qual "all") (name "family") (compare "not_eq"))
                                     (string "sans-serif"))
                               (test (@ (qual "all") (name "family") (compare "not_eq"))
                                     (string "serif"))
                               (test (@ (qual "all") (name "family") (compare "not_eq"))
                                     (string "monospace"))
                               (edit (@ (name "family") (mode "append_last"))
                                     (string "sans-serif")))
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
           (simple-service 'home-waybar-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("waybar"
                                   ,(local-file (string-append DOTFILES "waybar/")
                                                "waybar"
                                                #:recursive? #t))))
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
           (home-profile-package-service "alacritty")
           (home-profile-package-service "librewolf")
           (home-profile-package-service "gnupg")
           (home-profile-package-service '("hyprland"
                                           "hyprpolkitagent"
                                           "hyprpicker"
                                           "hyprpaper"
                                           "hyprshot"))
           (home-profile-package-service '("xdg-desktop-portal-gtk"
                                           "xdg-desktop-portal-hyprland"
                                           "xdg-desktop-portal-wlr"))
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
           (simple-service 'home-gtk-2-configuration-service
                           home-files-service-type
                           (list `(".gtkrc-2.0"
                                   ,(plain-file "gtkrc-2.0"
                                                "gtk-cursor-theme-name = \"Bibata-Modern-Classic\"
gtk-font-name = \"Cascadia Code NF\"
gtk-key-theme-name = \"Emacs\""))))
           (simple-service 'home-gtk-3-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("gtk-3.0/settings.ini"
                                   ,(local-file (string-append DOTFILES "gtk/settings.ini")
                                                "settings.ini"))))
           (simple-service 'home-ripgrep-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("ripgrep/ripgrep.conf"
                                   ,(local-file (string-append DOTFILES "ripgrep/ripgrep.conf")
                                                "ripgrep.conf"))))
           (simple-service 'home-fuzzel-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("fuzzel/fuzzel.ini"
                                   ,(local-file (string-append DOTFILES "fuzzel/fuzzel.ini")
                                                "fuzzel.ini"))))
           (simple-service 'home-alacritty-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("alacritty/alacritty.toml"
                                   ,(local-file (string-append DOTFILES "alacritty/alacritty.toml")
                                                "alacritty.toml"))))
           (simple-service 'home-fnott-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("fnott/fnott.ini"
                                   ,(local-file (string-append DOTFILES "fnott/fnott.ini")
                                                "fnott.ini"))))
           (simple-service 'home-television-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("television"
                                   ,(local-file (string-append DOTFILES "television/")
                                                "television"
                                                #:recursive? #t))))
           (home-profile-package-service "fnott")
           (home-profile-package-service "waybar")
           (home-profile-package-service "make")
           (home-profile-package-service "mpv")
           (home-profile-package-service "dolphin")
           (home-profile-package-service '("wl-clipboard"
                                           "clipman"))
           (home-profile-package-service "bibata-cursor-theme")
           (home-profile-package-service "fd")
           (home-profile-package-service "hicolor-icon-theme")
           (home-profile-package-service "starship")
           (simple-service 'home-starship-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("starship.toml"
                                   ,(local-file (string-append DOTFILES "starship/starship.toml")
                                                "starship.toml"))))
           %base-home-services))))
