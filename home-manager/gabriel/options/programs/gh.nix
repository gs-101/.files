{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-actions-lock
      gh-dash
      gh-markdown-preview
    ];
  };
}
