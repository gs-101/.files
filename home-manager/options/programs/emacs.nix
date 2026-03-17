{ pkgs, ... }:
let
  deps = with pkgs; [
    atool
    curl
    direnv
    ffmpeg
    mpv
    mupdf
    # Can't be added to mason-registry, see: <https://github.com/mason-org/mason-registry/pull/6725>
    nixd
    perl
    unzip
    wakatime-cli
    yt-dlp
    zotero
  ];
  emacsPkg = pkgs.symlinkJoin {
    name = "emacs-wrapped";
    paths = [ pkgs.emacs-git-pgtk ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
        --prefix PATH : "${pkgs.lib.makeBinPath deps}"
      wrapProgram $out/bin/emacsclient \
        --prefix PATH : "${pkgs.lib.makeBinPath deps}"
    '';
  };
in
{
  home = {
    sessionVariables = {
      EDITOR = "${emacsPkg}/bin/emacsclient -nw -a '${emacsPkg}/bin/emacs'";
      VISUAL = "${emacsPkg}/bin/emacsclient -c -a '${emacsPkg}/bin/emacs'";
    };
  };
  programs.emacs = {
    enable = true;
    package = emacsPkg;
  };
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "emacsclient.desktop" ];
    "x-scheme-handler/mailto" = [ "emacsclient-mail.desktop" ];
  };
}
