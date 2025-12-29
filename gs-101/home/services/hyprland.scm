(define-module (gs-101 home services hyprland)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages polkit)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu services)
  #:use-module (selected-guix-works packages qt)
  #:use-module (selected-guix-works packages wm)
  #:export (home-hyprland-service-type))

(define (home-hyprland-profile-service config)
  (list hypridle
        hyprland
        hyprlock
        hyprpicker
        hyprpolkitagent
        hyprqt6engine
        hyprshot
        waybar
        xdg-desktop-portal-hyprland))

(define (home-hyprland-environment-variables-service config)
  '(("HYPRCURSOR_THEME" . "Bibata-Modern-Classic")
    ("HYPRCURSOR_SIZE" . "24")
    ("QT_QPA_PLATFORMTHEME" . "hyprqt6engine")
    ("XCURSOR_THEME" . "Bibata-Modern-Classic")
    ("XCURSOR_SIZE" . "24")))

(define home-hyprland-service-type
  (service-type (name 'home-hyprland)
                (description "Service containing configurations specific to
Hyprland.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-hyprland-profile-service)
                       (service-extension
                        home-environment-variables-service-type
                        home-hyprland-environment-variables-service)))
                (default-value #f)))
