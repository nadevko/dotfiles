{
  buildFirefoxXpiAddon,
  fetchurl,
  lib,
  stdenvNoCC,
}:
import ./.generated.nix {
  inherit fetchurl lib buildFirefoxXpiAddon;
  stdenv = stdenvNoCC;
}
