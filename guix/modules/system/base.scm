(define-module (system base)
  #:use-module (gnu)
  #:use-module (guix colors)
  #:use-module (utils)
  #:export (base-system
            %base-desktop-services)
  #:re-export (keyboard-layout))

(use-service-modules containers
                     cups
                     desktop
                     nix
                     virtualization
                     xorg)

(define %base-desktop-services
  (modify-services %desktop-services
                   (delete gdm-service-type)
                   (guix-service-type config => (guix-configuration
                                                 (inherit config)
                                                 (authorized-keys
                                                  (cons* (dotfiles-file "guix/substitute-keys/nonguix.pub")
                                                         %default-authorized-guix-keys))
                                                 (substitute-urls
                                                  (cons* "https://substitutes.nonguix.org"
                                                         %default-substitute-urls))))))
(define keyboard-layout
  (keyboard-layout "br" #:options '("ctrl:nocaps")))

(define base-system
  (operating-system
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (keyboard-layout keyboard-layout)
     (targets (list "/boot/efi"))))
   (keyboard-layout keyboard-layout)
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
   (services (cons* (service cups-service-type)
                    (service nix-service-type)
                    (service qemu-binfmt-service-type
                             (qemu-binfmt-configuration
                              (platforms (lookup-qemu-platforms "arm" "aarch64"))))
                    (service rootless-podman-service-type)
                    %base-desktop-services))
   (timezone "America/Sao_Paulo")
   (users (cons* (user-account
                  (name "gabriel")
                  (comment "Gabriel Santos")
                  (group "users")
                  (home-directory "/home/gabriel")
                  (supplementary-groups '("audio"
                                          "cgroup" ; For podman
                                          "video"
                                          "wheel")))
                 %base-user-accounts))))
