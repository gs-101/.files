{
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      command_chaining = true;
      filter_mode_shell_up_key_binding = "workspace";
      sync_address = "https://atuin.gs-101.dev";
      sync_frequency = "15m";
      workspaces = true;
    };
  };
}
