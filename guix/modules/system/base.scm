(define-module (system base)
  #:use-module (gnu)
  #:use-module (guix colors)
  #:export (base-system))

(use-service-modules containers
                     cups
                     desktop
                     nix
                     virtualization
                     xorg)

(define desktop-services
  (let ((DOTFILES ".files/"))
    ;; HACK: This is the same hack originally used in the home
    ;; configuration to make local-file use absolute references.
    (modify-services %desktop-services
      (delete gdm-service-type)
      (guix-service-type config => (guix-configuration
                                    (inherit config)
                                    (authorized-keys
                                     (cons* (local-file (string-append DOTFILES "guix/substitute-keys/nonguix.pub"))
                                            %default-authorized-guix-keys))
                                    (substitute-urls
                                     (cons* "https://substitutes.nonguix.org"
                                            %default-substitute-urls)))))))
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
    (services (cons* (service cups-service-type)
                     (service nix-service-type)
                     (service qemu-binfmt-service-type
                              (qemu-binfmt-configuration
                               (platforms (lookup-qemu-platforms "arm" "aarch64"))))
                     (service rootless-podman-service-type)
                     desktop-services))
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
