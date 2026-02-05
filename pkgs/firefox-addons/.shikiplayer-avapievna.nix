{
  buildFirefoxXpiAddon,
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  nodejs,
  esbuild,
  zip,
}:
buildFirefoxXpiAddon {
  pname = "shikiplayer";
  version = "7.0.2.1-unstable";
  addonId = "{e6624e6b-2351-4a1d-b7b7-c714fffee424}";
  dontUnpack = true;

  meta = {
    homepage = "https://github.com/avapievna/Shikiplayer";
    description = "Adds Kodik player to Shikimori website";
    platforms = lib.platforms.all;
  };
  meta.mozPermissions = [
    "declarativeNetRequest"
    "*://shikimori.one/*"
    "*://shiki.one/*"
    "*://kodikapi.com/*"
    "*://qt-kaneko.github.io/*"
    "*://api.anilibria.tv/*"
    "*://api.alloha.tv/*"
    "*://apicollaps.cc/*"
    "*://api.kinobox.tv/*"
    "*://spapi.cbb40446.workers.dev/*"
    "*://www.anilibria.tv/*"
    "*://beggins-as.pljjalgo.online/*"
    "*://beggins-as.allarknow.online/*"
    "*://beggins-as.algonoew.online/*"
    "*://beggins-as.stloadi.live/*"
  ];

  src =
    let
      repo = fetchFromGitHub {
        owner = "avapievna";
        repo = "Shikiplayer";
        rev = "ff2be696b3bff7025f774a64f6c14c5f043639a7";
        hash = "sha256-EknWcAye3HJsSwDMaaqKVpm2JQMRwtwiIWUwwZ3jGGQ=";
      };
    in
    stdenvNoCC.mkDerivation {
      name = "shikiplayer.xpi";
      src = repo;
      nativeBuildInputs = [
        nodejs
        esbuild
        zip
      ];
      buildPhase = ''
        sed -i 's/await restore(CONFIG);//' build.js
        node build.js firefox --release
      '';
      installPhase = "cd dist && zip -r $out ./*";
    };
}
