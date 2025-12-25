(define-module (gs-101 system guix-notebook)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu packages)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gs-101 system base)
  #:use-module (nongnu system linux-initrd))

(operating-system
  (inherit base-system)
  (keyboard-layout (keyboard-layout "br" "thinkpad" #:options '("ctrl:nocaps")))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (keyboard-layout keyboard-layout)
      (targets (list "/boot/efi"))))
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
                       %base-file-systems))
  (firmware (map specification->package '("linux-firmware")))
  (host-name "guix-notebook")
  (initrd microcode-initrd)
  (kernel (specification->package "linux")))
