(define-module (gs-101 home services desktop)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnome-xyz)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages kde-internet)
  #:use-module (gnu packages librewolf)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages tor-browsers)
  #:use-module (gnu packages video)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu services)
  #:export (home-desktop-services))

(define (home-desktop-profile-service config)
  (list adw-gtk3-theme
        adwaita-icon-theme
        bibata-cursor-theme
        breeze-icons
        brightnessctl
        hicolor-icon-theme
        kdeconnect
        librewolf
        mpv
        torbrowser
        xdg-desktop-portal-gtk))

(define (home-desktop-environment-variables-service config)
  '(("GTK_2_RC_FILES" . "$XDG_CONFIG_HOME/gtk-2.0/settings.ini")
    ("QT_PLUGIN_PATH" . "$HOME/.guix-home/profile/lib/qt6/plugins")))

(define home-desktop-service-type
  (service-type (name 'home-desktop)
                (description "Service containing packages specific to a desktop
environment.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-desktop-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-desktop-environment-variables-service)))
                (default-value #f)))

(define home-desktop-services
  (list (service home-dbus-service-type)
        (service home-desktop-service-type)
        (service home-xdg-user-directories-service-type)))
