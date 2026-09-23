{ config, pkgs, ... }:
{
  accounts.email.maildirBasePath = "${config.xdg.dataHome}/mail";
  home = {
    preferXdgDirectories = true;
    sessionVariables = {
      PYTHON_HISTORY = "${config.xdg.dataHome}/python/history";
      RUSTUP_HOME = "${config.xdg.dataHome}/rust/rustup";
      WGETRC = "${config.xdg.dataHome}/wget/hosts";
      WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
    };
  };
  xdg = {
    enable = true;
    autostart = {
      enable = true;
      readOnly = true;
    };
    mimeApps.enable = true;
    terminal-exec.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
