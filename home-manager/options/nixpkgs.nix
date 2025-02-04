{ inputs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.emacs-overlay.overlays.default
      inputs.niri.overlays.niri
      inputs.nur.overlays.default
    ];
  };
}
