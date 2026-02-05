final: prev:
removeAttrs prev.firefox-addons [
  "buildFirefoxXpiAddon"
  "override"
  "overrideDerivation"
  "overrideAttrs"
]
// final.call ./.addons.nix { inherit (prev.firefox-addons) buildFirefoxXpiAddon; }
