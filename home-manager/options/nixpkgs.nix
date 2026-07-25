{ inputs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = with inputs; [
      emacs-overlay.overlays.default
      # neovim-nightly-overlay.overlays.default
      niri-nix.overlays.niri-nix
      noctalia.overlays.default
      nur.overlays.default
      self.overlays.default
    ];
  };
}
