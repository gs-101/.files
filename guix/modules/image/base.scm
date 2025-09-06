;; From nonguix:
;; <https://gitlab.com/nonguix/nonguix/-/blob/master/nongnu/system/install.scm>

(define-module (image base)
  #:use-module (guix channels)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:export (base-image))

(define %channels
  (list (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         (branch "master")
         (commit
          "b9d3169772b45a2457def49318173f8353bb34f9")
         (introduction
          (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
         (name 'guix)
         (url "https://codeberg.org/guix/guix")
         (branch "master")
         (commit
          "90f0f8713da9cf0dc0bb5c93446a4eba11075352")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

(define base-image
  (operating-system
   (inherit installation-os)
   (kernel (specification->package "linux"))
   (firmware (map specification->package '("linux-firmware")))
   (packages
    (append (specifications->packages '("curl"
                                        "git"
                                        "emacs-no-x"))
            (operating-system-packages installation-os)))
   (services
    (modify-services
     (operating-system-user-services installation-os)
     (guix-service-type config => (guix-configuration
                                   (inherit config)
                                   (guix (guix-for-channels %channels))
                                   (authorized-keys
                                    (cons* (dotfiles-file "guix/substitute-keys/nonguix.pub")
                                           (dotfiles-file "guix/substitute-keys/moe.pub")
                                           %default-authorized-guix-keys))
                                   (privileged? #f)
                                   (substitute-urls
                                    (cons* "https://substitutes.nonguix.org"
                                           "https://nonguix-proxy.ditigal.xyz"
                                           "https://cache-cdn.guix.moe"
                                           %default-substitute-urls))))))))

base-image
