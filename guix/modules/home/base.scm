(define-module (home base)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu home services admin)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services mail)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services sound)
  #:use-module (gnu home services syncthing)
  #:use-module (gnu home services xdg)
  ;; Home modules with "home-services" come from rde.
  #:use-module (gnu home-services version-control)
  #:use-module (guix gexp)
  #:use-module (selected-guix-works home services rust-apps)
  #:use-module (utils)
  #:export (base-home
            %base-home-packages)
  #:re-export (%base-home-services))

(define %base-home-packages
  (specifications->packages
   '("adw-gtk-theme"
     "adwaita-icon-theme"
     "alacritty"
     "bat"
     "bibata-cursor-theme"
     "cliphist"
     "cryptsetup"
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
     "gimp"
     "git:send-email"
     "gitu"
     "gnupg"
     "hicolor-icon-theme"
     "hyprland"
     "hyprpicker"
     "hyprpolkitagent"
     "hyprshot"
     "keepassxc"
     "inkscape"
     "librewolf"
     "libsecret" ; TODO: Make the executable a separate output.
     "make"
     "mpv"
     "mumi"
     "neovim"
     "nyxt" ; TODO: Use browser instead of Librewolf.
     "openssh"
     "pay-respects"
     "qt5ct"
     "rust-stakeholder"
     "starship"
     "swww-next"
     "torbrowser"
     "waybar"
     "wl-clipboard"
     "xdg-desktop-portal-hyprland"
     "xdg-utils"
     "zotero"
     "zoxide")))

(define %base-home-services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (aliases '(("grep" . "grep -P -i -n -H -q -R --devices=read --color=auto")
                             (".." . "cd ..")
                             ("bat" . "bat --color auto --decorations auto --paging never --theme=base16-256")
                             ("eza" . "eza -l -X --color auto --icons auto --hyperlink -a --group-directories-first --smart-group -h --changed --git")
                             ("ip" . "ip -color=auto")
                             ("df" . "df -H")
                             ("free" . "free -m -h --si")
                             ("fd" . "fd --follow --hyperlink=auto")))
                  (bash-profile (list (dotfiles-file "bash/.bash_profile")))
                  (bashrc (list (dotfiles-file "bash/.bashrc")))
                  (environment-variables '(("HISTCONTROL" . "ignoredups:erasedups")))))
        (service home-dbus-service-type)
        (service home-git-service-type
                 (home-git-configuration
                  (config
                   `((init
                      ((defaultBranch . "main")))
                     (sendemail
                      ((annotate . #t)
                       (sendmailCmd . ,(file-append (specification->package "msmtp") "/bin/msmtp"))))
                     (user
                      ((email . "gabrielsantosdesouza@disroot.org")
                       (name . "Gabriel Santos")))))
                  (ignore '("*.elc"
                            "*-autoloads.el"
                            "*-pkg.el"
                            "*.DS_Store"))))
        (service home-gpg-agent-service-type
                 (home-gpg-agent-configuration
                  (pinentry-program
                   (file-append (specification->package "pinentry-qt") "/bin/pinentry-qt"))
                  (ssh-support? #t)))
        (service home-log-rotation-service-type) ; From the original %base-home-services.
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
                     ("menu-complete-display-prefix" . #t)))))
        (service home-msmtp-service-type
                 (home-msmtp-configuration
                  (accounts
                   (list
                    (msmtp-account
                     (name "default")
                     (configuration
                      (msmtp-configuration
                       (host "disroot.org")
                       (port 465)
                       (user "gabrielsantosdesouza")
                       (password-eval
                        ;; secret-tool can be used with KeePassXC to
                        ;; comfortably get passwords for scripts.
                        ;; See:
                        ;; <https://redlib.freedit.eu/r/linux/comments/ehfhud/keyring_alternative_access_keepassxc_entries_of/>
                        "secret-tool lookup msmtp password")
                       (from "gabrielsantosdesouza@disroot.org"))))))
                  (defaults
                    (msmtp-configuration
                     (auth? #t)
                     (tls? #t)
                     (tls-starttls? #f)))))
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
        (service home-shepherd-timer-service-type) ; From the original %base-home-services.
        (service home-shepherd-transient-service-type) ; From the original %base-home-services.
        (service home-syncthing-service-type
                 (for-home
                  (syncthing-configuration
                   (user "gabriel"))))
        (service home-xdg-mime-applications-service-type
                 (home-xdg-mime-applications-configuration
                  (default
                    '((inode/directory . emacsclient.desktop)
                      (x-scheme-handler/mailto . emacsclient-mail.desktop)))))
        (service home-xdg-user-directories-service-type)
        (simple-service 'home-alacritty-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("alacritty/alacritty.toml"
                                ,(dotfiles-file "alacritty/alacritty.toml"))))
        (simple-service 'home-fnott-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("fnott/fnott.ini"
                                ,(dotfiles-file "fnott/fnott.ini"))))
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
        (simple-service 'home-fuzzel-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("fuzzel/fuzzel.ini"
                                ,(dotfiles-file "fuzzel/fuzzel.ini"))))
        (simple-service 'home-gitu-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("gitu/config.toml"
                                ,(dotfiles-file "gitu/config.toml"))))
        (simple-service 'home-gtk-2-configuration-service
                        home-files-service-type
                        (list `(".gtkrc-2.0"
                                ,(plain-file "gtkrc-2.0"
                                             "gtk-cursor-theme-name = \"Bibata-Modern-Classic\"
gtk-font-name = \"Cascadia Code NF\"
gtk-key-theme-name = \"Emacs\""))))
        (simple-service 'home-gtk-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("gtk-3.0/settings.ini"
                                ,(dotfiles-file "gtk/settings.ini"))
                              `("gtk-3.0/gtk.css"
                                ,(dotfiles-file "gtk/colors.css"))
                              `("gtk-4.0/settings.ini"
                                ,(dotfiles-file "gtk/settings.ini"))
                              `("gtk-4.0/gtk.css"
                                ,(dotfiles-file "gtk/colors.css"))))
        (simple-service 'home-hyprland-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("hypr/hyprland.conf"
                                ,(dotfiles-file "hypr/hyprland.conf"))))
        (simple-service 'home-makefile-service
                        home-files-service-type
                        (list `("Makefile"
                                ,(dotfiles-file "Makefile"))))
        (simple-service 'home-matugen-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("matugen"
                                ,(dotfiles-file "matugen" #:recursive? #t))))
        (simple-service 'home-nix-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("nix/nix.conf"
                                ,(plain-file "nix.conf"
                                             "experimental-features = nix-command flakes"))))
        (simple-service 'home-nix-home-manager-service
                        home-xdg-configuration-files-service-type
                        (list `("home-manager"
                                ,(dotfiles-file "nix/home" #:recursive? #t))))
        (simple-service 'home-qt-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("qt5ct/qt5ct.conf"
                                ,(dotfiles-file "qt/settings.conf"))
                              `("qt6ct/qt6ct.conf"
                                ,(dotfiles-file "qt/settings.conf"))))
        (simple-service 'home-starship-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("starship.toml"
                                ,(dotfiles-file "starship/starship.toml"))))
        (simple-service 'home-television-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("television/config.toml"
                                ,(dotfiles-file "television/config.toml"))
                              `("television/channels.toml"
                                ,(dotfiles-file "television/channels.toml"))))
        (simple-service 'home-variables-service
                        home-environment-variables-service-type
                        `(("BROWSER" . "librewolf")
                          ("DOTFILES" . "$HOME/.files")
                          ("EDITOR" . "emacsclient -nw -a 'emacs -nw'")
                          ("QT_QPA_PLATFORMTHEME" . "qt5ct")
                          ("SHELL" . "bash")
                          ("TERM" . "alacritty")
                          ("TERMINAL" . "alacritty")
                          ("VISUAL" . "emacsclient --create-frame -a 'emacs'")))
        (simple-service 'home-wakatime-configuration-service
                        home-files-service-type
                        (list `(".wakatime.cfg"
                                ,(dotfiles-file "wakatime/.wakatime.cfg"))))
        (simple-service 'home-waybar-configuration-service
                        home-xdg-configuration-files-service-type
                        (list `("waybar/config.jsonc"
                                ,(dotfiles-file "waybar/config.jsonc"))
                              `("waybar/style.css"
                                ,(dotfiles-file "waybar/style.css"))))))

(define base-home
  (home-environment
   (packages %base-home-packages)
   (services %base-home-services)))
