(define-module (gs-101 home services niri)
  #:use-module (gnu home services)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages polkit)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:export (home-niri-service-type))

(define (home-niri-profile-service config)
  (list hyprpicker
        hyprpolkitagent
        niri
        waybar
        xdg-desktop-portal-gnome
        xwayland-satellite))

(define home-niri-service-type
  (service-type (name 'home-niri)
                (description "Service containing configurations specific to
Niri.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-niri-profile-service)))
                (default-value #f)))
