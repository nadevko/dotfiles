{
  lib,
  stdenvNoCC,
  fetchurl,

  writeShellApplication,
  mozilla-addons-to-nix
}:
lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;

  extendDrvArgs =
    _:
    {
      url,
      sha256,
      addonId,
      passthru ? { },
      ...
    }:
    {
      src = fetchurl { inherit url sha256; };

      dontBuild = true;

      installPhase = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir --parents "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';

      passthru = passthru // {
        updateScript = writeShellApplication {
          name = "firefox-addons-update";
          runtimeInputs = [ mozilla-addons-to-nix ];
          text = ''
            mozilla-addons-to-nix "''${1:-$PWD}/pkgs/firefox-addon/addons.json" "''${1:-$PWD}/pkgs/firefox-addon/.generated.nix"
          '';
        };
        inherit addonId;
      };

      preferLocalBuild = true;
      allowSubstitutes = true;
    };

  excludeDrvArgNames = [
    "url"
    "sha256"
    "addonId"
  ];
}
