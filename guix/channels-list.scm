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
        (name 'ollama-guix)
        (url "https://codeberg.org/tusharhero/ollama-guix.git")
        (branch "master"))
       (channel
        (name 'emacs-master)
        (url "https://github.com/gs-101/emacs-master.git")
        (branch "main")
        (introduction
         (make-channel-introduction
          "568579841d0ca41a9d222a2cfcad9a7367f9073b"
          (openpgp-fingerprint
           "3049 BF6C 0829 94E4 38ED  4A15 3033 E0E9 F7E2 5FE4"))))
       %default-channels)
