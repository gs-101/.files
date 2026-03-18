{ ... }:
{
  programs.television = {
    enable = true;
    settings = {
      preview = {
        env = {
          BAT_THEME = "ansi";
        };
      };
      ui = {
        theme = "noctalia";
      };
    };
  };
}
