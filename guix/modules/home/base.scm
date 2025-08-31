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
  '("adw-gtk3-theme"
    "adwaita-icon-theme"
    "alacritty"
    "bat"
    "bibata-cursor-theme"
    "cliphist"
    "cryptsetup"
    "direnv"
    "emacs-master-pgtk-igc"
    "eza"
    "fd"
    "fnott"
    "font-aporetic"
    "font-google-noto"
    "font-google-noto-emoji"
    "font-google-noto-sans-cjk"
    "font-google-noto-serif-cjk"
    "font-microsoft-cascadia"
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
    "kdeconnect"
    "kdenlive"
    "keepassxc"
    "inkscape"
    "librewolf"
    "libsecret"
    "make"
    "mpv"
    "mumi"
    "neovim"
    "obs"
    "openssh"
    "ouch"
    "pay-respects"
    "qt5ct"
    "rust-stakeholder"
    "starship"
    "swww-next"
    "torbrowser"
    "waybar"
    "wl-clipboard"
    "wtype"
    "xdg-desktop-portal-hyprland"
    "xdg-utils"
    "zotero"
    "zoxide"))

(define %base-home-services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (aliases '(("grep" . "grep --perl-regexp --ignore-case --line-number  --with-filename --quiet -R --devices=read --color=auto")
                             (".." . "cd ..")
                             ("bat" . "bat --color auto --decorations auto --paging never --theme=base16-256")
                             ("eza" . "eza --long --dereference --color auto --icons auto --hyperlink --all --group-directories-first --smart-group --header --changed --git")
                             ("ip" . "ip -color=auto")
                             ("df" . "df --human-readable")
                             ("free" . "free --mebi --human")
                             ("fd" . "fd --follow --hyperlink=auto")))
                  (bash-profile
                   (list (plain-file
                          "bash-profile"
                          (string-append-n
                           "# Set up Nix profile."
                           "if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then"
                           "source /run/current-system/profile/etc/profile.d/nix.sh"
                           "fi"
                           "# Source home-manager."
                           "if [ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then"
                           "source ~/.nix-profile/etc/profile.d/hm-session-vars.sh"
                           "fi"))))
                  (bashrc
                   (list (plain-file
                          "bashrc"
                          (string-append-n
                           "# Define the GPG_TTY as the one being currently used."
                           "# This fixes so many issues that it should be a default."
                           "export GPG_TTY=$(tty)"
                           "# gpg-agent frustratingly doesn't seem to update on startup."
                           "# This restarts it so SSH keys can be used."
                           "gpg-connect-agent updatestartuptty /bye >/dev/null"
                           "# Do not overwrite history."
                           "shopt -s histappend"
                           "# Recursive globbing."
                           "shopt -s globstar"
                           "# Enable shell integration for direnv."
                           "eval \"$(direnv hook bash)\""
                           "# Enable starship prompt only in graphical environments,"
                           "# as I like to hang out in the kernel terminal sometimes."
                           "if [ -n \"$DISPLAY\" ]; then eval \"$(starship init bash)\"; fi"
                           "# Enable shell integration for television."
                           "eval \"$(tv init bash)\""
                           "# Enable shell integration for pay-respects."
                           "eval \"$(pay-respects bash)\""
                           "# Enable shell integration for zoxide."
                           "eval \"$(zoxide init bash)\""
                           "# I don't use fzf. This replaces zoxide's fzf integration with"
                           "# television, my preferred fuzzy finder."
                           "function __zoxide_zi() {" ; TODO: define-bash-function procedure?
                           "  result=\"$(zoxide query --list -- \"$@\" | tv)\" && cd \"$result\""
                           "}"
                           "# Disable flow control keybinds (that freeze your terminal)."
                           "stty -ixon"))))
                  (environment-variables '(("HISTCONTROL" . "ignoredups:erasedups")))))
        (service home-dbus-service-type)
        (service home-git-service-type
                 (home-git-configuration
                  (config
                   `((init
                      ((defaultBranch . "main")))
                     (sendemail
                      ((annotate . #t)
                       (sendmailCmd . ,(file-command "msmtp"))))
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
                   (file-command "pinentry-qt"))
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
                         ;; Alias deprecated mono to monospace.
                         '(match (@ (target "pattern"))
                            (test (@ (qual "any") (name "family"))
                                  (string "mono"))
                            (edit (@ (name "family") (mode "assign"))
                                  (string "monospace")))
                         ;; Not recognized aliases default to the sans-serif font.
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
                            (family "Cascadia Mono NF")
                            ;; General fallback.
                            (family "Noto Sans Mono")
                            ;; Simplified Chinese.
                            (family "Noto Sans Mono CJK SC")
                            ;; Japanese.
                            (family "Noto Sans Mono CJK JP")
                            ;; Korean.
                            (family "Noto Sans Mono CJK KR")))
                         '(alias
                           (family "serif")
                           (prefer
                            (family "Aporetic Serif")
                            ;; General fallback.
                            (family "Noto Serif")
                            ;; Simplified Chinese.
                            (family "Noto Serif CJK SC")
                            ;; Japanese.
                            (family "Noto Serif CJK JP")
                            ;; Korean.
                            (family "Noto Serif CJK KR")))
                         '(alias
                           (family "sans-serif")
                           (prefer
                            (family "Cascadia Code NF")
                            ;; General fallback.
                            (family "Noto Sans")
                            ;; Simplified Chinese.
                            (family "Noto Sans CJK SC")
                            ;; Japanese.
                            (family "Noto Sans CJK JP")
                            ;; Korean.
                            (family "Noto Sans CJK KR")))
                         '(alias
                           (family "emoji")
                           (prefer
                            (family "Noto Color Emoji")))))
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
        (simple-service 'home-nix-home-manager-service
                        home-xdg-configuration-files-service-type
                        (list `("home-manager"
                                ,(dotfiles-file "nix/home" #:recursive? #t))))
        (simple-service 'home-pay-respects-service
                        home-xdg-configuration-files-service-type
                        (list `("pay-respects/config.toml"
                                ,(plain-file
                                  "config.toml"
                                  (string-append-n
                                   "# Runs the suggestion in the current shell,"
                                   "# Allowing one to correct \"exit\" for example."
                                   "eval_method = \"Shell\""
                                   "[package_manager]"
                                   "package_manager = \"guix\""
                                   "# Spawns a shell with the package instead of"
                                   "# polluting the profile."
                                   "install_method = \"Shell\"")))))
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
                          ("EDITOR" . "emacsclient --create-frame --no-window-system --alternate-editor=''")
                          ("QT_QPA_PLATFORMTHEME" . "qt5ct")
                          ("SHELL" . "bash")
                          ("TERM" . "alacritty")
                          ("TERMINAL" . "alacritty")
                          ("VISUAL" . "emacsclient --create-frame --alternate-editor=''")))
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
    (packages (specifications->packages %base-home-packages))
    (services %base-home-services)))
