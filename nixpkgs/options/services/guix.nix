{ ... }:
{
  services = {
    guix = {
      enable = true;
      substituters = {
        authorizedKeys = [
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
          # "https://substitutes.nonguix.org"
          "https://cache-cdn.guix.moe"
        ];
      };
    };
  };
}
