{
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_address = "https://atuin.gs-101.dev";
      sync_frequency = "15m";
      workspaces = true;
    };
  };
}
