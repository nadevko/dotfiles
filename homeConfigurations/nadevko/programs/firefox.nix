{ pkgs, ... }:
{
  imports = [ ../../../homeModules/firefox-gnome-theme ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [ gnome-browser-connector ];
    languagePacks = [ "be" ];
  };

  programs.firefox.profiles.default = {
    id = 0;
    isDefault = true;
    settings = {
      "accessibility.browsewithcaret" = false;
      "accessibility.typeaheadfind" = false;
      "app.normandy.api_url" = "";
      "app.normandy.enabled" = false;
      "app.shield.optoutstudies.enabled" = false;
      "beacon.enabled" = false;
      "breakpad.reportURL" = "";
      "browser.aboutConfig.showWarning" = false;
      "browser.bookmarks.showMobileBookmarks" = true;
      "browser.contentblocking.category" = "strict";
      "browser.crashReports.unsubmittedCheck.enabled" = false;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.display.underline_links" = false;
      "browser.download.folderList" = 1;
      "browser.download.useDownloadDir" = true;
      "browser.engagement.ctrlTab.has-used" = true;
      "browser.gnome-search-provider.enabled" = true;
      "browser.link.open_newwindow.override.external" = 3;
      "browser.link.open_newwindow.restriction" = 0;
      "browser.link.open_newwindow.ui.last" = 3;
      "browser.link.open_newwindow" = 3;
      "browser.messaging-system.whatsNewPanel.enabled" = false;
      "browser.newtabpage.activity-stream.default.sites" = "";
      "browser.newtabpage.activity-stream.enabled" = true;
      "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = true;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = true;
      "browser.newtabpage.activity-stream.feeds.snippets" = true;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.newtabpage.enabled" = true;
      "browser.ping-centre.telemetry" = false;
      "browser.preferences.useRecommendedPerformanceSettings" = true;
      "browser.safebrowsing.allowOverride" = false;
      "browser.safebrowsing.blockedURIs.enabled" = false;
      "browser.safebrowsing.downloads.enabled" = false;
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      "browser.safebrowsing.provider.google.gethashURL" = "";
      "browser.safebrowsing.provider.google.updateURL" = "";
      "browser.safebrowsing.provider.google4.dataSharingURL" = "";
      "browser.safebrowsing.provider.google4.gethashURL" = "";
      "browser.safebrowsing.provider.google4.updateURL" = "";
      "browser.search.defaultenginename" = "DuckDuckGo";
      "browser.search.showOneOffButtons" = true;
      "browser.search.suggest.enabled" = true;
      "browser.search.update" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.startup.homepage" = "about:home";
      "browser.startup.page" = 3;
      "browser.tabs.crashReporting.sendReport" = false;
      "browser.tabs.loadDivertedInBackground" = true;
      "browser.tabs.loadInBackground" = true;
      "browser.tabs.tabmanager.enabled" = true;
      "browser.tabs.warnOnClose" = false;
      "browser.uitour.enabled" = false;
      "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
      "browser.urlbar.quicksuggest.enabled" = true;
      "browser.urlbar.quicksuggest.impressionCaps.sponsoredEnabled" = false;
      "browser.urlbar.quicksuggest.onboardingDialogChoice" = "reject_2";
      "browser.urlbar.quicksuggest.scenario" = "offline";
      "browser.urlbar.suggest.bookmark" = true;
      "browser.urlbar.suggest.history" = true;
      "browser.urlbar.suggest.openpage" = true;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.trimURLs" = false;
      "browser.warnOnQuit" = false;
      "browser.warnOnQuitShortcut" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "dom.allow_cut_copy" = true;
      "dom.event.clipboardevents.enabled" = false;
      "dom.popup_allowed_events" = "";
      "dom.security.https_only_mode_pbm" = true;
      "dom.security.https_only_mode" = true;
      "extensions.autoDisableScopes" = 0;
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "extensions.pocket.enabled" = false;
      "extensions.systemAddon.update.enabled" = false;
      "extensions.systemAddon.update.url" = "";
      "general.autoScroll" = false;
      "general.smoothScroll" = true;
      "geo.provider.network.logging.enabled" = false;
      "gfx.webrender.all" = true;
      "identity.fxaccounts.account.device.name" = "nadevko@klinicyst Firefox";
      "intl.accept_languages" = "be,ru,en-GB,en-US";
      "intl.locale.requested" = "be,en-GB";
      "intl.regional_prefs.use_os_locales" = true;
      "layout.css.prefers-color-scheme.content-override" = 2;
      "layout.spellcheckDefault" = 1;
      "media.eme.enabled" = false;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardwaremediakeys.enabled" = true;
      "media.videocontrols.picture-in-picture.enabled" = true;
      "network.dns.blockDotOnion" = false;
      "network.http.referer.hideOnionSource" = true;
      "network.IDN_show_punycode" = true;
      "network.proxy.socks_remote_dns" = true;
      "network.proxy.type" = 5;
      "network.trr.mode" = 2;
      "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
      "pdfjs.disabled" = false;
      "pdfjs.enableScripting" = false;
      "places.history.enabled" = true;
      "privacy.resistFingerprinting.pbmode" = true;
      "privacy.resistFingerprinting" = false;
      "privacy.userContext.enabled" = true;
      "privacy.userContext.ui.enabled" = true;
      "security.ask_for_password" = 0;
      "security.OCSP.enabled" = 1;
      "services.sync.enabled" = true;
      "services.sync.engine.addons" = true;
      "services.sync.engine.creditcards" = false;
      "services.sync.engine.prefs.modified" = true;
      "services.sync.engine.prefs" = true;
      "sidebar.verticalTabs" = false;
      "signon.management.page.breach-alerts.enabled" = false;
      "signon.passwordEditCapture.enabled" = false;
      "signon.rememberSignons" = false;
      "toolkit.coverage.endpoint.base" = "";
      "toolkit.coverage.opt-out" = true;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.native-messaging" = 0;
      "xpinstall.whitelist.required" = true;
    };
    extensions.packages = with pkgs.firefox-addons; [
      absolute-enable-right-click
      adaptive-tab-bar-colour
      darkreader
      gnome-shell-integration
      gsconnect
      keepassxc-browser
      react-devtools
      return-youtube-dislikes
      search-by-image
      simple-translate
      skip-redirect
      sponsorblock
      ublock-origin
      voice-over-translation
      watch-on-shikimori
      web-archives
      zotero-connector
    ];
    themes.gnome = {
      enable = true;
      settings = {
        hideSingleTab = true;
        bookmarksToolbarUnderTabs = true;
        allTabsButtonOnOverflow = true;
      };
      extensions.settings.adaptiveTabBarColour = true;
    };
  };
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };
}
