{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        ms-azuretools.vscode-containers
        ms-vscode-remote.remote-containers
        tuttieee.emacs-mcx
      ];
    };
  };
}
