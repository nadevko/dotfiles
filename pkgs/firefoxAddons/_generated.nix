{
  buildFirefoxXpiAddon,
  fetchurl,
  lib,
  stdenv,
}:
{
  "dollchan-extension" = buildFirefoxXpiAddon {
    pname = "dollchan-extension";
    version = "24.9.16.0";
    addonId = "dollchan_extension@dollchan.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/4353774/dollchan_extension-24.9.16.0.xpi";
    sha256 = "0024a191719b4bac2c38db5ad499c31e3ffc7855ec38a020cfed463cca7c0a18";
    meta = with lib; {
      homepage = "https://dollchan.net/";
      description = "The best way to browse imageboards! (New version)";
      license = licenses.mit;
      mozPermissions = [
        "<all_urls>"
        "notifications"
        "storage"
        "tabs"
        "unlimitedStorage"
        "webNavigation"
      ];
      platforms = platforms.all;
    };
  };
  "shikiplayer" = buildFirefoxXpiAddon {
    pname = "shikiplayer";
    version = "6.0.11";
    addonId = "{e6624e6b-2351-4a1d-b7b7-c714fffee424}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4421759/shikiplayer-6.0.11.xpi";
    sha256 = "4ba382901228fb5457cfeb742a0ba9e9f834ee700e32a6e8ac6428fca175dff4";
    meta = with lib; {
      homepage = "https://github.com/qt-kaneko/Shikiplayer";
      description = "Adds Kodik player to Shikimori website";
      mozPermissions = [
        "*://kodik.info/*"
        "*://*.cloud.kodik-storage.com/*"
        "*://kodikapi.com/*"
        "*://videocdn.tv/*"
        "*://apicollaps.cc/*"
        "*://qt-kaneko.github.io/*"
        "*://api.anilibria.tv/*"
        "*://api.alloha.tv/*"
        "*://shikimori.one/*"
        "*://api.lib.social/*"
        "*://www.anilibria.tv/*"
        "*://beggins-as.pljjalgo.online/*"
        "*://beggins-as.allarknow.online/*"
        "*://beggins-as.algonoew.online/*"
        "*://anilib.me/iframe-player/*"
      ];
      platforms = platforms.all;
    };
  };
}
