{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libgcc,
}:
stdenv.mkDerivation rec {
  name = "spacetimedb-0.8.2";
  src = fetchurl {
    url = "https://github.com/clockworklabs/SpacetimeDB/releases/download/v0.8.2-beta-hotfix7/spacetime.linux-amd64.tar.gz";
    sha256 = "a67dbf7eb0435c4fc9164c5a404232f415e2e079c77efb11aebb6bff6b47ab4d";
  };
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [libgcc stdenv.cc.cc.lib];
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r spacetime  $out/bin/spacetime
    runHook postInstall
  '';
}
