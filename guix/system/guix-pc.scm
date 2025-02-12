(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules cups
                     desktop
                     nix
                     xorg
                     containers)

(define %gs-101/desktop-services  
  (modify-services %desktop-services
    (delete gdm-service-type)
    (guix-service-type config => (guix-configuration
                                  (inherit config)
                                  (substitute-urls
                                   (append (list "https://substitutes.nonguix.org")
                                           %default-substitute-urls))
                                  (authorized-keys
                                   ;; REFACTOR: Using a plain string like this in a distro that can
                                   ;; build entire packages from source with code seems a bit silly.
                                   (append (list (plain-file "non-guix.pub"
                                                             "(public-key (ecc (curve Ed25519) (q
#C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                                           %default-authorized-guix-keys))))))

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
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
                (supplementary-groups '("wheel"
                                        "netdev"
                                        "audio"
                                        "video")))
               %base-user-accounts))

 (packages (append
            (map specification->package+output
                 '("git"
                   "nix"
                   "direnv"))
            %base-packages))

 (issue "
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
")

 (services (cons* (service cups-service-type)
                  (service nix-service-type)
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
