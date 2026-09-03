{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.mcp = {
    enable = true;
    servers.git.command = lib.getExe pkgs.mcp-server-git;
  };
}
