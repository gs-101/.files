{ config, ... }:
{
  accounts.email.maildirBasePath = "${config.xdg.dataHome}/mail";
  home = {
    preferXdgDirectories = true;
    sessionVariables = {
      PYTHON_HISTORY = "${config.xdg.dataHome}/python/history";
      RUSTUP_HOME = "${config.xdg.dataHome}/rust/rustup";
      WGETRC = "${config.xdg.dataHome}/wget/hosts";
      WAKATIME_HOME = "${config.xdg.dataHome}/wakatime";
    };
  };
  programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";
  xdg = {
    enable = true;
    autostart = {
      enable = true;
      readOnly = true;
    };
    mimeApps.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    terminal-exec.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
