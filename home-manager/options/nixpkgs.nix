{ inputs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = with inputs; [
      emacs-overlay.overlays.default
      neovim-nightly-overlay.overlays.default
      nix-vscode-extensions.overlays.default
      niri.overlays.niri
      noctalia.overlays.default
      noctalia-qs.overlays.default
      nur.overlays.default
    ];
  };
}
