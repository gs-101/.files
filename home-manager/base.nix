{ ... }:
{
  imports = [
    ./options/fonts.nix
    ./options/gtk.nix
    ./options/home.nix
    ./options/nixpkgs.nix
    ./options/qt.nix
    ./options/xdg.nix
    ./options/programs/alacritty.nix
    ./options/programs/anki.nix
    ./options/programs/bash.nix
    ./options/programs/bat.nix
    ./options/programs/direnv.nix
    ./options/programs/emacs.nix
    ./options/programs/fd.nix
    ./options/programs/gh.nix
    ./options/programs/gpg.nix
    ./options/programs/msmtp.nix
    ./options/programs/noctalia-shell.nix
    ./options/programs/notmuch.nix
    ./options/programs/nvf.nix
    ./options/programs/password-store.nix
    ./options/programs/pay-respects.nix
    ./options/programs/ripgrep.nix
    ./options/programs/television.nix
    ./options/programs/starship.nix
    ./options/programs/wakatime.nix
    ./options/services/gpg-agent.nix
  ];
  programs = {
    home-manager.enable = true;
    librewolf.enable = true;
    keepassxc.enable = true;
    mpv.enable = true;
    mbsync.enable = true;
    nh.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
  services = {
    kdeconnect.enable = true;
    podman.enable = true;
    syncthing.enable = true;
  };
  xdg = {
    enable = true;
    configFile."guix/channels.scm".text = ''
      (list (channel
          (name 'emacs-master)
          (url "https://github.com/gs-101/emacs-master")
          (branch "main")
          (commit
            "ccc16b8e6c19f166c4fab9b90a0ccc880837f5bd")
          (introduction
            (make-channel-introduction
              "568579841d0ca41a9d222a2cfcad9a7367f9073b"
              (openpgp-fingerprint
                "3049 BF6C 0829 94E4 38ED  4A15 3033 E0E9 F7E2 5FE4"))))
        (channel
          (name 'guix)
          (url "https://codeberg.org/guix/guix")
          (branch "master")
          (commit
            "1a73454e551d87ccd4cbaec162cdd659dcc9a9e1")
          (introduction
            (make-channel-introduction
              "9edb3f66fd807b096b48283debdcddccfea34bad"
              (openpgp-fingerprint
                "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
        (channel
          (name 'nonguix)
          (url "https://gitlab.com/nonguix/nonguix")
          (branch "master")
          (commit
            "cbf5bd14cc0888caee8cf6e6abd9ec7c111307d7")
          (introduction
            (make-channel-introduction
              "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
              (openpgp-fingerprint
                "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'rde)
          (url "https://git.sr.ht/~abcdw/rde")
          (branch "master")
          (commit
            "56fb304903e0df13e33bbf0edb1f3c4494a367c8")
          (introduction
            (make-channel-introduction
              "257cebd587b66e4d865b3537a9a88cccd7107c95"
              (openpgp-fingerprint
                "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
        (channel
          (name 'rosenthal)
          (url "https://codeberg.org/hako/rosenthal.git")
          (branch "trunk")
          (commit
            "8f13fe96155128841268fab62709911f0747090e")
          (introduction
            (make-channel-introduction
              "7677db76330121a901604dfbad19077893865f35"
              (openpgp-fingerprint
                "13E7 6CD6 E649 C28C 3385  4DF5 5E5A A665 6149 17F7"))))
        (channel
          (name 'selected-guix-works)
          (url "https://github.com/gs-101/selected-guix-works")
          (branch "main")
          (commit
            "4cf9e6459472974ceed098364683bb08073f53ea")
          (introduction
            (make-channel-introduction
              "5d1270d51c64457d61cd46ec96e5599176f315a4"
              (openpgp-fingerprint
                "C780 21F7 34E4 07EB 9090  0CF1 4ACA 6D6F 89AB 3162")))))
    '';
  };
}
