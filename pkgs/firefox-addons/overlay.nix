final: prev:
removeAttrs prev.firefox-addons [
  "buildFirefoxXpiAddon"
  "override"
  "overrideDerivation"
  "overrideAttrs"
]
// import ./.generated.nix {
  inherit (final) lib;
  inherit (prev.firefox-addons) buildFirefoxXpiAddon;
  fetchurl = null;
  stdenv = null;
}
// {
  recurseForDerivations = true;
}
