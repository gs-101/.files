{
  fetchurl,
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "nd-lyrics";
  version = "8.0.0";

  src = fetchurl {
    url = "https://github.com/J0R6IT0/navidrome-lyrics-plugin/releases/download/v${finalAttrs.version}/nd-lyrics.ndp";
    hash = "sha256-7vfUje9U8LtlAzuBudaVkSxka34aYFjK3W1pvlBuUog=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share
    cp $src $out/share/nd-lyrics.ndp
    ln -s nd-lyrics.ndp $out/share/navidrome-lyrics-plugin.ndp

    runHook postInstall
  '';

  passthru = {
    isNavidromePlugin = true;
  };

  meta = {
    description = "Navidrome plugin to fetch lyrics from multiple remote sources";
    homepage = "https://github.com/J0R6IT0/navidrome-lyrics-plugin";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
})
