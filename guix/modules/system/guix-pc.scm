(define-module (system guix-pc)
  #:use-module (gnu)
  #:use-module (nongnu system linux-initrd)
  #:use-module (system base))

(operating-system
  (inherit base-system)
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "2e34a2ed-1a32-4ef5-9c73-da47fab9183f"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "E7EB-39CF"
                                       'fat32))
                         (type "vfat"))
                       %base-file-systems))
  (firmware (map specification->package '("linux-firmware")))
  (host-name "guix-pc")
  (initrd microcode-initrd)
  (kernel (specification->package "linux")))
