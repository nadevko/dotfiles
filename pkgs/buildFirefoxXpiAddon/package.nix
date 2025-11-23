{
  stdenvNoCC,
  lib,
  fetchurl,
  system,
  writeShellApplication,
  inputs ? { },
  mozilla-addons-to-nix ? inputs.mozilla-addons-to-nix.packages.${system}.default,

  pname ? "private-relay",
  version ? "2.8.1",
  addonId ? "private-relay@firefox.com",
  url ? "https://addons.mozilla.org/firefox/downloads/file/4205650/private_relay-2.8.1.xpi",
  sha256 ? "4a85ddc1cd19d2a156c4efe76225d424c0c32e700ab77601f8c1e50d7975cd9d",
  meta ? {
    homepage = "https://relay.firefox.com/";
    description = "Firefox Relay lets you generate email aliases that forward to your real inbox. Use it to hide your real email address and protect yourself from hackers and unwanted mail.";
    license = lib.licenses.mpl20;
    mozPermissions = [
      "<all_urls>"
      "storage"
      "menus"
      "contextMenus"
      "https://relay.firefox.com/"
      "https://relay.firefox.com/**"
      "https://relay.firefox.com/accounts/profile/**"
      "https://relay.firefox.com/accounts/settings/**"
    ];
    platforms = lib.platforms.all;
  },
}:
stdenvNoCC.mkDerivation {
  src = fetchurl { inherit url sha256; };

  inherit meta pname version;
  preferLocalBuild = true;
  allowSubstitutes = true;

  passthru = {
    updateScript = writeShellApplication {
      name = "firefox-addons-update";
      runtimeInputs = [ mozilla-addons-to-nix ];
      text = ''
        mozilla-addons-to-nix "''${1:-$PWD}/pkgs/firefoxAddons/addons.json" "''${1:-$PWD}/pkgs/firefoxAddons/.generated.nix"
      '';
    };
    inherit addonId;
  };

  buildCommand = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p "$dst"
    install -v -m644 "$src" "$dst/${addonId}.xpi"
  '';
}
