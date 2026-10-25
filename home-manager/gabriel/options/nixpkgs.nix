{ inputs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = with inputs; [
      llm-agents.overlays.shared-nixpkgs
      neovim-nightly-overlay.overlays.default
      noctalia.overlays.default
      nur.overlays.default
      self.overlays.default
      umbriel.overlays.default
    ];
  };
}
