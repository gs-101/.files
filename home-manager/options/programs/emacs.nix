{ pkgs, ... }:
let
  emacs = pkgs.emacs-git-pgtk;
in
  {
    home = {
      packages = with pkgs; [
      atool
      curl
      direnv
      ffmpeg
      mpv
      mupdf
      perl
      unzip
      wakatime-cli
      yt-dlp
      zotero
      ];
      sessionVariables = {
        EDITOR = "${emacs}/bin/emacsclient -nw -a '${emacs}/bin/emacs'";
        VISUAL = "${emacs}/bin/emacsclient --c -a '${emacs}/bin/emacs'";
      };
    };
    programs.emacs = {
      enable = true;
      package = emacs;
    };
    xdg.mimeApps.defaultApplications = {
      "inode/directory" = [ "emacsclient.desktop" ];
      "x-scheme-handler/mailto" = [ "emacsclient-mail.desktop" ];
    };
  }
