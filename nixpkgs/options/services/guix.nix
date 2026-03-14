{ ... }:
{
  services = {
    guix = {
      enable = true;
      substituters = {
        authorizedKeys = [
          (builtins.fetchurl {
            url = "https://codeberg.org/guix/guix/raw/branch/master/etc/substitutes/berlin.guix.gnu.org.pub";
            sha256 = "0bvrs7fifrqdv8sqkxxh4jcfbvjygcxyfl5njqqkaxdc9rhm2zhg";
          })
          (builtins.fetchurl {
            url = "https://codeberg.org/guix/guix/raw/branch/master/etc/substitutes/bordeaux.guix.gnu.org.pub";
            sha256 = "0czmmcf2i4qhsxdjb3zcjcw0s12769vmgm7x34w8b0l639mbb1r7";
          })
          # (builtins.fetchurl {
          #   url = "https://substitutes.nonguix.org/signing-key.pub";
          #   sha256 = "0000000000000000000000000000000000000000000000000000";
          # })
          (builtins.fetchurl {
            url = "https://ci.guix.moe/signing-key.pub";
            sha256 = "0sw1alhb8qrwcq6zq8arivyhraa8x1xrrcqr9z17gnby2w5i1z9v";
          })
        ];
        urls = [
          "http://bordeaux.guix.gnu.org"
          "http://berlin.guix.gnu.org"
          # "https://substitutes.nonguix.org"
          "https://cache-cdn.guix.moe"
        ];
      };
    };
  };
}
