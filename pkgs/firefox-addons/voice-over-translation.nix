{ buildFirefoxXpiAddon, lib }:
buildFirefoxXpiAddon rec {
  pname = "voice-over-translation";
  version = "1.11.1";
  addonId = "vot-extension@firefox";
  url = "https://github.com/ilyhalight/${pname}/releases/download/${version}/vot-extension-firefox-${version}.xpi";
  sha256 = "sha256-X3ZsVVAXNtuQloRMY0v382zxYT2GE5a9ra0BfpfO5mE=";
  meta = with lib; {
    homepage = "https://votdocs.toil.cc/ecosystem/voice-over-translation.html";
    description = "Небольшое расширение, которое добавляет закадровый перевод видео из YaBrowser в другие браузеры";
    license = licenses.mit;
    mozPermissions = [
      "storage"
      "notifications"
      "tabs"
      "declarativeNetRequestWithHostAccess"
      "*://*.yandex.ru/*"
      "*://*.disk.yandex.kz/*"
      "*://*.disk.yandex.com/*"
      "*://*.disk.yandex.com.am/*"
      "*://*.disk.yandex.com.ge/*"
      "*://*.disk.yandex.com.tr/*"
      "*://*.disk.yandex.by/*"
      "*://*.disk.yandex.az/*"
      "*://*.disk.yandex.co.il/*"
      "*://*.disk.yandex.ee/*"
      "*://*.disk.yandex.lt/*"
      "*://*.disk.yandex.lv/*"
      "*://*.disk.yandex.md/*"
      "*://*.disk.yandex.net/*"
      "*://*.disk.yandex.tj/*"
      "*://*.disk.yandex.tm/*"
      "*://*.disk.yandex.uz/*"
      "*://*.disk.360.yandex.ru/*"
      "*://*.yandex.net/*"
      "*://*.timeweb.cloud/*"
      "*://*.raw.githubusercontent.com/*"
      "*://*.vimeo.com/*"
      "*://*.toil.cc/*"
      "*://*.deno.dev/*"
      "*://*.onrender.com/*"
      "*://*.workers.dev/*"
      "*://*.cloudflare-dns.com/*"
      "*://*.porntn.com/*"
      "*://*.googlevideo.com/*"
    ];
    platforms = platforms.all;
  };
}
