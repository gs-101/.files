(use-modules (gnu)
             (guix colors) ; For issue
             (nongnu system linux-initrd))

(use-service-modules containers
                     cups
                     desktop
                     nix
                     virtualization
                     xorg)

(define %gs-101/desktop-services
  (modify-services %desktop-services
    (delete gdm-service-type)
    (guix-service-type config => (guix-configuration
                                  (inherit config)
                                  (authorized-keys
                                   (append (list (local-file "../substitute-keys/nonguix.pub"))
                                           %default-authorized-guix-keys))
                                  (substitute-urls
                                   (append (list "https://substitutes.nonguix.org")
                                           %default-substitute-urls))))))

(operating-system
 (keyboard-layout (keyboard-layout "br" #:options '("ctrl:nocaps")))
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (keyboard-layout keyboard-layout)
   (targets (list "/boot/efi"))))
 (file-systems (cons* (file-system
                       (mount-point "/")
                       (device (uuid
                                "32f6f5f3-040b-419a-a90b-11207887cd41"
                                'btrfs))
                       (type "btrfs"))
                      (file-system
                       (mount-point "/boot/efi")
                       (device (uuid "6C59-0ADD"
                                     'fat32))
                       (type "vfat"))
                      %base-file-systems))
 (firmware (specifications->packages '("linux-firmware")))
 (host-name "guix-pc")
 (initrd microcode-initrd)
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
 (kernel (specification->package "linux"))
 (locale "en_US.utf8")
 (packages %base-packages)
 (services (cons* (service cups-service-type)
                  (service nix-service-type)
                  (service qemu-binfmt-service-type
                           (qemu-binfmt-configuration
                            (platforms (lookup-qemu-platforms "arm" "aarch64"))))
                  (service rootless-podman-service-type)
                  %gs-101/desktop-services))
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
               %base-user-accounts)))
