{
  fetchFromGitHub,
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "semble-skill";
  version = "0.6.2";

  src = fetchFromGitHub {
    owner = "MinishLab";
    repo = "semble";
    tag = "v${finalAttrs.version}";
    hash = "sha256-piUdFOTKGc/Nk8pHIP68VQOhpZMfXDCSV0OIkrD5SjA=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    printf -- '---\nname: %s\ndescription: %s\n---\n\n' \
      "semble" \
      "Code search tool using natural-language or code queries to find implementations instead of grep or glob." \
      > $out/SKILL.md

    sed -n '/{SEMBLE_START}/,/{SEMBLE_END}/{ /{SEMBLE_START}/d; /{SEMBLE_END}/d; p; }' src/semble/installer/agents.py \
      | sed 's/{SEMBLE_PIN}/semble[mcp]==${finalAttrs.version}/g' \
      >> $out/SKILL.md

    runHook postInstall
  '';

  meta = {
    description = "Semble skill for AI coding agents";
    homepage = "https://github.com/MinishLab/semble";
    license = lib.licenses.mit;
  };
})
