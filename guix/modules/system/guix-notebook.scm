(define-module (system guix-notebook)
  #:use-module (gnu)
  #:use-module (nongnu system linux-initrd)
  #:use-module (system base)
  #:re-export (keyboard-layout))



(define keyboard-layout
  (keyboard-layout "br" "thinkpad" #:options '("ctrl:nocaps")))

(opertating-system
 (inherit base-system)
 (host-name "guix-notebook")
 (initrd microcode-initrd)
 (kernel (specification->package "linux"))
 (mapped-devices (list (mapped-device
                        (source (uuid
                                 "9e7f9a43-3f83-4b73-aa14-91fc2f6125c2"))
                        (target "root")
                        (type luks-device-mapping))))
 (file-systems (cons* (file-system
                        (mount-point "/")
                        (device "/dev/mapper/root")
                        (type "btrfs")
                        (dependencies mapped-devices))
                      (file-system
                        (mount-point "/boot/efi")
                        (device (uuid "1121-4D41"
                                      'fat32))
                        (type "vfat"))
                      %base-file-systems)))
