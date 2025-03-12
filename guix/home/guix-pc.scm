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
             (gnu home services mail)
             ;; Home modules with "home-services" come from rde.
             (gnu home-services password-utils)
             (gnu home-services version-control)
             (selected-guix-works home services rust-apps))

(home-environment
 (packages (specifications->packages '("alacritty"
                                       "bat"
                                       "bibata-cursor-theme"
                                       "clipman"
                                       "direnv"
                                       "emacs-master-pgtk"
                                       "eza"
                                       "fd"
                                       "fnott"
                                       "font-aporetic"
                                       "font-google-noto-emoji"
                                       "font-microsoft-cascadia"
                                       "font-nerd-fonts-m-plus"
                                       "fuzzel"
                                       "git:send-email"
                                       "gnupg"
                                       "hicolor-icon-theme"
                                       "hyprland"
                                       "hyprpaper"
                                       "hyprpicker"
                                       "hyprpolkitagent"
                                       "hyprshot"
                                       "librewolf"
                                       "make"
                                       "mpv"
                                       "neovim"
                                       "pay-respects"
                                       "openssh"
                                       "selected-guix-works-backgrounds"
                                       "starship"
                                       "torbrowser"
                                       "waybar"
                                       "xdg-desktop-portal-hyprland")))
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
                      `(("editing-mode" . "emacs")
                        ("colored-stats" . #t)
                        ("colored-completion-prefix" . #t)))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration
                     (pinentry-program
                      (file-append pinentry-qt "/bin/pinentry-qt"))
                     (ssh-support? #t)))
           (service home-msmtp-service-type
                    (home-msmtp-configuration
                     (defaults (msmtp-configuration
                                (auth? #t)
                                (tls? #t)
                                (tls-starttls? #f)))
                     (accounts (list
                                (msmtp-account
                                 (name "default")
                                 (configuration
                                  (msmtp-configuration
                                   (host "disroot.org")
                                   (port 465)
                                   (user "gabrielsantosdesouza")
                                   (password-eval "pass gabrielsantosdesouza@disroot.org")
                                   (from "gabrielsantosdesouza@disroot.org"))))))))
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
                               (family "Noto Color Emoji")))
                            ;; Use the M+ Nerd Font for japanese text.
                            '(match
                                 (test (@ (name "lang") (compare "contains"))
                                       (string "ja"))
                               (test (@ (name "family"))
                                     (string "sans-serif"))
                               (edit (@ (name "family") (mode "prepend"))
                                     (string "M+1 Nerd Font Propo")))))
           (service home-syncthing-service-type
                    (for-home
                     (syncthing-configuration
                      (user "gabriel"))))
           (service home-dbus-service-type)
           (service home-pipewire-service-type)
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
           (service home-password-store-service-type
                    (home-password-store-configuration
                     (directory "~/.password-store")))
           (service home-git-service-type
                    (home-git-configuration
                     (config
                      `((sendmail
                         ((sendmailCmd . ,(file-append (specification->package "msmtp") "/bin/msmtp"))))))
                     (ignore '("*.elc"
                               "*-autoloads.el"
                               "*-pkg.el"
                               "*.DS_Store"))))
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
           (simple-service 'home-wakatime-service
                           home-files-service-type
                           (list `(".wakatime.cfg"
                                   ,(local-file (string-append DOTFILES "wakatime/.wakatime.cfg")
                                                "wakatime.cfg"))))
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
           (simple-service 'home-gtk-4-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("gtk-4.0/settings.ini"
                                   ,(local-file (string-append DOTFILES "gtk/settings.ini")
                                                "settings.ini"))))
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
           (simple-service 'home-starship-configuration-service
                           home-xdg-configuration-files-service-type
                           (list `("starship.toml"
                                   ,(local-file (string-append DOTFILES "starship/starship.toml")
                                                "starship.toml"))))
           %base-home-services))))
