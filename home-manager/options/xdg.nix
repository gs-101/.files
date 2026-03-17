{ ... }:
{
  home.preferXdgDirectories = true;
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
