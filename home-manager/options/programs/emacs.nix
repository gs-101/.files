{ pkgs, ... }:
let
  emacs = pkgs.emacs-git-pgtk;
in
  {
    home.sessionVariables = {
      EDITOR = "${emacs}/bin/emacsclient -nw -a '${emacs}/bin/emacs'";
      VISUAL = "${emacs}/bin/emacsclient --c -a '${emacs}/bin/emacs'";
    };
    programs.emacs = {
      enable = true;
      extraPackages = (p: [ p.treesit-grammars.with-all-grammars ]);
      package = emacs;
    };
  }
