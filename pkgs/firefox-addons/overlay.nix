final: prev:
let
  generated = import ./.generated.nix {
    inherit (final)
      lib
      fetchurl
      stdenv
      buildFirefoxXpiAddon
      ;
  };
in
removeAttrs prev.firefox-addons [
  "buildFirefoxXpiAddon"
  "override"
  "overrideDerivation"
  "overrideAttrs"
]
// generated
// {
  shikiplayer =
    let
      fork = final.callPackage ./.shikiplayer-avapievna.nix { };
      upstream = generated.shikiplayer or null;
    in
    if upstream != null && 0 < (builtins.compareVersions upstream.version fork.version) then
      builtins.warn "WARNING: Shikiplayer upstream (${upstream.version}) is newer than fork (${fork.version}). Using upstream!" upstream
    else
      fork;
}
