(define-module (gs-101 system base)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu packages containers)
  #:use-module (gnu packages man)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services containers)
  #:use-module (gnu services cups)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu services nix)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (gnu system)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system shadow)
  #:use-module (guix colors)
  #:use-module (guix gexp)
  #:export (base-system))

(define base-desktop-services
  (modify-services %desktop-services
    (delete gdm-service-type)
    (guix-service-type config => (guix-configuration
                                   (inherit config)
                                   (authorized-keys
                                    (cons* (local-file "substitute-keys/nonguix.pub")
                                           (local-file "substitute-keys/moe.pub")
                                           %default-authorized-guix-keys))
                                   (privileged? #f)
                                   (substitute-urls
                                    (cons* "https://substitutes.nonguix.org"
                                           "https://nonguix-proxy.ditigal.xyz"
                                           "https://cache-cdn.guix.moe"
                                           %default-substitute-urls))))))

(define base-system
  (operating-system
   (keyboard-layout (keyboard-layout "br" #:options '("ctrl:nocaps")))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (keyboard-layout keyboard-layout)
     (targets (list "/boot/efi"))))
   (file-systems (cons* (file-system
                         (mount-point "/")
                         (device "/dev/sda1")
                         (type "ext4"))
                        %base-file-systems))
   (host-name "base-system")
   (issue (colorize-string "
 ..                             `.
 `--..```..`           `..```..--`
   .-:///-:::.       `-:::///:-.
      ````.:::`     `:::.````
           -//:`    -::-
            ://:   -::-
            `///- .:::`
             -+++-:::.
              :+/:::-
              `-....`
" (color CYAN)))
   (locale "en_US.utf8")
   (packages (cons* podman-compose
                    man-db ; For the "man" command. Important!
                    %base-packages))
   (services (cons* (service cups-service-type)
                    (service iptables-service-type) ; Podman requirement.
                    (service nix-service-type
                             (nix-configuration
                              (extra-config
                               '("experimental-features = nix-command flakes"))))
                    ;; For Guix package development.
                    (service qemu-binfmt-service-type
                             (qemu-binfmt-configuration
                              (platforms (lookup-qemu-platforms "arm" "aarch64"))))
                    (service rootless-podman-service-type
                             (rootless-podman-configuration
                              (subgids
                               (list (subid-range (name "gabriel"))))
                              (subuids
                               (list (subid-range (name "gabriel"))))))
                    base-desktop-services))
   (timezone "America/Sao_Paulo")
   (users (cons* (user-account
                  (name "gabriel")
                  (comment "Gabriel Santos")
                  (group "users")
                  (home-directory "/home/gabriel")
                  (supplementary-groups '("audio"
                                          "cgroup" ; For podman
                                          "video"
                                          "kvm"
                                          "wheel")))
                 %base-user-accounts))))

base-system
