{
  buildFirefoxXpiAddon,
  fetchurl,
  lib,
  stdenvNoCC,
}:
import ./.generated.nix {
  inherit fetchurl lib;
  stdenv = stdenvNoCC;
  buildFirefoxXpiAddon = buildFirefoxXpiAddon.override;
}
