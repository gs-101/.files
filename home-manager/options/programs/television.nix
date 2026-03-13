{ ... }:
{
  programs.television = {
    enable = true;
    enableBashIntegration = true;
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
