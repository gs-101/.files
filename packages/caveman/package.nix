{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "caveman";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "JuliusBrussee";
    repo = "caveman";
    tag = "v${finalAttrs.version}";
    hash = "sha256-TYDx7QMgSVczVqNIzVHhctmD4mJWn9UE2MWchRhX77Q=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 $src/skills/caveman/SKILL.md $out/caveman/SKILL.md

    runHook postInstall
  '';
})
