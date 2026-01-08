(define-module (gs-101 system guix-pc)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services virtualization)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gs-101 system base)
  #:use-module (nongnu system linux-initrd))

(operating-system
 (inherit base-system)
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
 (firmware (map specification->package '("linux-firmware")))
 (host-name "guix-pc")
 (initrd microcode-initrd)
 (kernel (specification->package "linux"))
 (services (cons* (service qemu-binfmt-service-type ; For Guix package development.
                           (qemu-binfmt-configuration
                            (platforms (lookup-qemu-platforms "arm" "aarch64"))))
                  base-services)))
