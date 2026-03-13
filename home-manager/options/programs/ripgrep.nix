{ ... }:
{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Automatically switch to Perl Compatible Regular Experssions if
      # functionality specific to them is used.
      "--engine=auto"
      # Follow symbolic links. Useful in this "software in a store" model.
      "--follow"
      # Enable hyperlinks on output.
      "--hyperlink-format=default"
      "--search-zip"
      # Search case-insensitively when all text is lowercase.
      "--smart-case"
    ];
  };
}
