{ pkgs }:

pkgs.symlinkJoin {
  name = "gopass-pass";
  paths = [ pkgs.gopass ];

  postBuild = ''
    ln -s gopass "$out/bin/pass"
  '';
}
