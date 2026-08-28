{ gopass, symlinkJoin }:

symlinkJoin {
  name = "gopass-pass";
  paths = [ gopass ];

  postBuild = ''
    ln -s gopass "$out/bin/pass"
  '';
}
