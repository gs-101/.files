{
  fetchFromGitHub,
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "emacs-skills";
  version = "0-unstable-2026-07-21";

  src = fetchFromGitHub {
    owner = "xenodium";
    repo = "emacs-skills";
    rev = "a158238bd630ebe68f57fb9caf99e984e757ca4f";
    hash = "sha256-ZWikhVPlgTw5TqgXU8pCZSRPvnSAxHCqnqgiZvAuV+8=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r $src/skills/* $out/

    runHook postInstall
  '';

  meta = {
    description = "Claude Code skills for Emacs integration";
    homepage = "https://github.com/xenodium/emacs-skills";
    license = lib.licenses.mit;
  };
}
