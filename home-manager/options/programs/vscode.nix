{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        cunbidun.flash-vscode
        tuttieee.emacs-mcx
        vscjava.vscode-java-pack
        wakatime.vscode-wakatime
      ];
    };
  };
}
