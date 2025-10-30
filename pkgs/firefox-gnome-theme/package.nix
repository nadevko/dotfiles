{
  fetchFromGitHub,
  writeTextDir,
  stdenvNoCC,
  lib,
  firefox,
  inputs,

  hideSingleTab ? null,
  normalWidthTabs ? null,
  swapTabClose ? null,
  bookmarksToolbarUnderTabs ? null,
  activeTabContrast ? null,
  closeOnlySelectedTabs ? null,
  systemIcons ? null,
  noThemedIcons ? null,
  symbolicTabIcons ? null,
  hideWebrtcIndicator ? null,
  hideUnifiedExtensions ? null,
  dragWindowHeaderbarButtons ? null,
  tabsAsHeaderbar ? null,
  oledBlack ? null,
  allTabsButtonOnOverflow ? null,
  allTabsButton ? null,
  tabAlignLeft ? null,
  bookmarksOnFullscreen ? null,

  themeConfig ? {
    inherit
      hideSingleTab
      normalWidthTabs
      swapTabClose
      bookmarksToolbarUnderTabs
      activeTabContrast
      closeOnlySelectedTabs
      systemIcons
      noThemedIcons
      symbolicTabIcons
      hideWebrtcIndicator
      hideUnifiedExtensions
      dragWindowHeaderbarButtons
      tabsAsHeaderbar
      oledBlack
      allTabsButtonOnOverflow
      allTabsButton
      tabAlignLeft
      bookmarksOnFullscreen
      ;
  },

  adaptiveTabBarColour ? null,

  extensionsConfig ? { inherit adaptiveTabBarColour; },
}:
let
  inherit (builtins)
    concatStringsSep
    mapAttrs
    all
    isBool
    attrValues
    ;
  inherit (lib.attrsets) filterAttrs mapAttrs' nameValuePair;

  extensionsConfig' = mapAttrs' (n: nameValuePair "extensions.${n}") extensionsConfig;
  config = filterAttrs (_: v: v != null) (themeConfig // extensionsConfig');
in
assert all isBool (attrValues config);
stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "143";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-0E3TqvXAy81qeM/jZXWWOTZ14Hs1RT7o78UyZM+Jbr4=";
  };

  patches = [ ./0001-Remove-custom-css-loads.patch ];

  installPhase = ''
    mkdir --parent $out/lib/firefox/chrome
    cp --recursive theme $out/lib/firefox/chrome
    install -Dm644 userContent.css $out/lib/firefox/chrome
    install -Dm644 userChrome.css $out/lib/firefox/chrome
    install -Dm644 configuration/user.js $out/lib/firefox
  '';

  passthru.userjs = writeTextDir "lib/firefox/user.js" (
    concatStringsSep "\n" (
      attrValues (
        mapAttrs (n: v: ''user_pref("gnomeTheme.${n}", ${if v then "true" else "false"});'') config
      )
    )
  );

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
    platforms = firefox.meta.platforms;
    maintainers = [ inputs.self.lib.maintainers.nadevko ];
  };
}
