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
  version = "1.3.0";
  sources = {
    x86_64-linux = {
      url = "https://dl.google.com/agy-extensions/releases/linux/agy-acp-server-${version}-linux-x86_64.zip";
      sha256 = "144vc9p9a2yzg3y2hpnplkz1h5k2giqiv1j8bvamm9advs6z1ns6";
    };
    aarch64-linux = {
      url = "https://dl.google.com/agy-extensions/releases/linux/agy-acp-server-${version}-linux-arm64.zip";
      sha256 = "0lr4b018l9l7dq4garmf6pwrzm4slv5cad8wxlwvpb8ki02l13rs";
    };
    aarch64-darwin = {
      url = "https://dl.google.com/agy-extensions/releases/macos/agy-acp-server-${version}-darwin-arm64.zip";
      sha256 = "0001m22qpga4bcdrfq62vh6m44l7d8w18iif278k9wbmvdam8gq4";
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
