final: prev:
let
  override = { inherit (prev.firefox-addons) buildFirefoxXpiAddon; };
in
removeAttrs prev.firefox-addons [
  "buildFirefoxXpiAddon"
  "override"
  "overrideDerivation"
  "overrideAttrs"
]
// final.call ./.addons.nix override
// {
  voice-over-translation = final.callPackage ./voice-over-translation.nix override;
}
