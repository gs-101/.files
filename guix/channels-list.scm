(cons* (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         (branch "master")
         (introduction
          (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
         (name 'emacs-master)
         (url "https://github.com/gs-101/emacs-master.git")
         (branch "main")
         (introduction
          (make-channel-introduction
           "568579841d0ca41a9d222a2cfcad9a7367f9073b"
           (openpgp-fingerprint
            "3049 BF6C 0829 94E4 38ED  4A15 3033 E0E9 F7E2 5FE4"))))
       (channel
         (name 'guix-rust-past-crates)
         (url "https://codeberg.org/guix/guix-rust-past-crates.git")
         (branch "trunk")
         (introduction
          (make-channel-introduction
           "1db24ca92c28255b28076792b93d533eabb3dc6a"
           (openpgp-fingerprint
            "F4C2 D1DF 3FDE EA63 D1D3  0776 ACC6 6D09 CA52 8292"))))
       (channel
         (name 'selected-guix-works)
         (url "https://github.com/gs-101/selected-guix-works.git")
         (branch "main")
         (introduction
          (make-channel-introduction
           "5d1270d51c64457d61cd46ec96e5599176f315a4"
           (openpgp-fingerprint
            "C780 21F7 34E4 07EB 9090  0CF1 4ACA 6D6F 89AB 3162"))))
       (channel
         (name 'rde)
         (url "https://git.sr.ht/~abcdw/rde")
         (introduction
          (make-channel-introduction
           "257cebd587b66e4d865b3537a9a88cccd7107c95"
           (openpgp-fingerprint
            "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
       %default-channels)
