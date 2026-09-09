{ inputs, ... }:
{
  nixpkgs.overlays = with inputs; [
    self.overlays.default
  ];
}
