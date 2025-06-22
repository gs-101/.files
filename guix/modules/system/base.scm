(define-module (system base)
  #:use-module (gnu)
  #:use-module (guix colors)
  #:use-module (utils)
  #:export (base-system
            %base-desktop-services))

(use-service-modules containers
                     cups
                     desktop
                     nix
                     virtualization
                     xorg)

(define %base-packages
  ;; Aliases @command{docker} to @command{podman}.
  (append (specifications->packages '("podman:docker"))
          %base-packages))

(define %base-desktop-services
  (modify-services %desktop-services
    (delete gdm-service-type)
    (guix-service-type config => (guix-configuration
                                  (inherit config)
                                  (authorized-keys
                                   (cons* (dotfiles-file "guix/substitute-keys/nonguix.pub")
                                          %default-authorized-guix-keys))
                                  (privileged? #f)
                                  (substitute-urls
                                   (cons* "https://substitutes.nonguix.org"
                                          "https://nonguix-proxy.ditigal.xyz"
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
    (packages %base-packages)
    (services (cons* (service cups-service-type)
                     (service nix-service-type
                              (nix-configuration
                               (extra-config
                                '("experimental-features = nix-command flakes"))))
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
