(use-modules (gnu)
             (nongnu system linux-initrd)
             (guix colors))

(use-service-modules cups
                     desktop
                     nix
                     xorg
                     containers
                     virtualization)

(define %gs-101/desktop-services
  (modify-services %desktop-services
    (delete gdm-service-type)
    (guix-service-type config => (guix-configuration
                                  (inherit config)
                                  (substitute-urls
                                   (append (list "https://substitutes.nonguix.org")
                                           %default-substitute-urls))
                                  (authorized-keys
                                   (append (list (local-file "../substitute-keys/nonguix.pub"))
                                           %default-authorized-guix-keys))))))

(operating-system
  (kernel (specification->package "linux"))
  (initrd microcode-initrd)
  (firmware (map specification->package
                 '("linux-firmware")))
  (locale "en_US.utf8")
  (timezone "America/Sao_Paulo")
  (keyboard-layout (keyboard-layout "br"
                                    #:options '("ctrl:nocaps")))
  (host-name "guix-pc")

  (users (cons* (user-account
                 (name "gabriel")
                 (comment "Gabriel Santos")
                 (group "users")
                 (home-directory "/home/gabriel")
                 (supplementary-groups '("audio"
                                         "cgroup" ; Podman
                                         "video"
                                         "wheel")))
                %base-user-accounts))

  (packages %base-packages)

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

  (services (cons* (service cups-service-type)
                   (service nix-service-type)
                   (service qemu-binfmt-service-type
                            (qemu-binfmt-configuration
                             (platforms (lookup-qemu-platforms "arm" "aarch64"))))
                   (service rootless-podman-service-type)
                   %gs-101/desktop-services))

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))

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
                         (type "vfat")) %base-file-systems)))
