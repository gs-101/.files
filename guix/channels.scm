(list (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (branch "master")
        (commit
          "473e5a62cd512cc0d5b4ac2c33be0bc0d0379435")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
        (name 'emacs-master)
        (url "https://github.com/gs-101/emacs-master.git")
        (branch "main")
        (commit
          "0fd9f56bc3dfc3d00c3c6aa652393961ed5dec0e")
        (introduction
          (make-channel-introduction
            "568579841d0ca41a9d222a2cfcad9a7367f9073b"
            (openpgp-fingerprint
              "3049 BF6C 0829 94E4 38ED  4A15 3033 E0E9 F7E2 5FE4"))))
      (channel
        (name 'selected-guix-works)
        (url "https://github.com/gs-101/selected-guix-works.git")
        (branch "main")
        (commit
          "1f9fa5a02ddefafe64b1333b76d2d2944785521e")
        (introduction
          (make-channel-introduction
            "5d1270d51c64457d61cd46ec96e5599176f315a4"
            (openpgp-fingerprint
              "C780 21F7 34E4 07EB 9090  0CF1 4ACA 6D6F 89AB 3162"))))
      (channel
        (name 'rde)
        (url "https://git.sr.ht/~abcdw/rde")
        (branch "master")
        (commit
          "8f5cc42ce3c0d229511ce1bdec38969081933114")
        (introduction
          (make-channel-introduction
            "257cebd587b66e4d865b3537a9a88cccd7107c95"
            (openpgp-fingerprint
              "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
      (channel
        (name 'guix)
        (url "https://git.guix.gnu.org/guix.git")
        (branch "master")
        (commit
          "90ef2f48b144ca619c660b062e16818ab0a43418")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
