(use-modules (gnu)
             (gnu packages shellutils)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules cups
                     desktop
                     docker
                     networking
                     nix
                     ssh
                     xorg)

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "America/Sao_Paulo")
  (keyboard-layout (keyboard-layout "br-abnt"
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
                                         "video"
                                         "docker")))
                %base-user-accounts))

  (packages (append
             (map specification->package+output
                  '("git"
                    "nix"
                    "containerd"
                    "docker"
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
                   (service containerd-service-type)
                   (service docker-service-type)
                   (set-xorg-configuration
                    (xorg-configuration (keyboard-layout keyboard-layout)))
                   (modify-services %desktop-services
                     (delete gdm-service-type)
                     (delete sddm-service-type)
                     (delete screen-locker-service-type))))

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
