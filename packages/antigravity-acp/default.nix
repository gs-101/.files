{
  autoPatchelfHook,
  cacert,
  fetchzip,
  lib,
  makeWrapper,
  stdenv,
  zlib,
}:
let
  version = "20260818_01_RC01";
  sources = {
    x86_64-linux = {
      url = "https://dl.google.com/agy-extensions/releases/linux/agy-acp-server-agy_acp_server_${version}-linux-x86_64.zip";
      sha256 = "1pmj5nl9nvaqzsf757v75lql08x3fkfl82ksr0777p97jqrh0qdz";
    };
    aarch64-linux = {
      url = "https://dl.google.com/agy-extensions/releases/linux/agy-acp-server-agy_acp_server_${version}-linux-arm64.zip";
      sha256 = "18d7b49adbvyb1j2042wvpjbifxisbh7b31sx93lmckjz20ym5ci";
    };
    aarch64-darwin = {
      url = "https://dl.google.com/agy-extensions/releases/macos/agy-acp-server-agy_acp_server_${version}-darwin-arm64.zip";
      sha256 = "080585navmxkcfql3dgbyngsn5jwmwp5xvavkz6sgzfrs5ixyjvx";
    };
  };
  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "antigravity-acp";
  inherit version;

  src = fetchzip {
    inherit (source) url sha256;
    stripRoot = false;
  };

  nativeBuildInputs = [
    makeWrapper
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    stdenv.cc.cc.lib
    zlib
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/libexec/antigravity-acp
    cp -r * $out/libexec/antigravity-acp/

    chmod +x $out/libexec/antigravity-acp/agy_acp_server.par
    if [ -f "$out/libexec/antigravity-acp/localharness_external" ]; then
      chmod +x $out/libexec/antigravity-acp/localharness_external
      ln -s $out/libexec/antigravity-acp/localharness_external $out/bin/localharness_external
      ln -s $out/libexec/antigravity-acp/localharness_external $out/bin/localharness
    fi

    makeWrapper $out/libexec/antigravity-acp/agy_acp_server.par $out/bin/agy_acp_server \
      --prefix PATH : "$out/bin:$out/libexec/antigravity-acp" \
      --set-default ANTIGRAVITY_HARNESS_PATH "$out/libexec/antigravity-acp/localharness_external" \
      --set-default SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt" \
      --set-default NIX_SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt"

    ln -s agy_acp_server $out/bin/agy_acp_server.par
    ln -s agy_acp_server $out/bin/antigravity-acp

    runHook postInstall
  '';

  meta = {
    description = "Google Antigravity Agent Client Protocol (ACP) Server";
    homepage = "https://antigravity.google/docs/ide/extensions";
    license = lib.licenses.unfree;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    mainProgram = "agy_acp_server";
  };
}
