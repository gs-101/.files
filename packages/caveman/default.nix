{
  fetchFromGitHub,
  lib,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "caveman";
  version = "2.3.1";

  src = fetchFromGitHub {
    owner = "JuliusBrussee";
    repo = "caveman";
    tag = "v${finalAttrs.version}";
    hash = "sha256-zQJ5fVaEuUjQoboJm9SvStwHI8kmqwyxecOSYvzuVBQ=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 $src/skills/caveman/SKILL.md $out/SKILL.md

    runHook postInstall
  '';
})
