{ pkgs, ... }:
let
  deps = with pkgs; [
    antigravity-acp
    atool
    copilot-language-server
    curl
    direnv
    ffmpeg
    imagemagick
    mpv
    mupdf
    nerd-fonts.symbols-only
    perl
    unzip
    wakatime-cli
    zip
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
    "application/pdf" = [ "emacsclient.desktop" ];
    "inode/directory" = [ "emacsclient.desktop" ];
    "x-scheme-handler/mailto" = [ "emacsclient-mail.desktop" ];
  };
}
