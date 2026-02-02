{ buildFirefoxXpiAddon, lib }:
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
    version = "7.0.2";
    addonId = "{e6624e6b-2351-4a1d-b7b7-c714fffee424}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4584039/shikiplayer-7.0.2.xpi";
    sha256 = "c723ee01de2776674e1a0935fd77357fb62de4b24aaf36434cbc27e2e278fb93";
    meta = with lib; {
      homepage = "https://github.com/qt-kaneko/Shikiplayer";
      description = "Adds Kodik player to Shikimori website";
      mozPermissions = [
        "declarativeNetRequest"
        "*://shikimori.one/*"
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
      platforms = platforms.all;
    };
  };
}
