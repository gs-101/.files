{ ... }:
{
  programs = {
    fd = {
      enable = true;
      extraOptions = [
        # Follow symbolic links. Useful in this "software in a store" model.
        "--follow"
        # Enable hyperlinks on output.
        "--hyperlink=auto"
      ];
    };
  };
}
