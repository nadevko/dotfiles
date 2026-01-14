{
  lib,
  stdenvNoCC,
  buildFirefoxXpiAddon,
  fetchurl,
}:
import ./.generated.nix {
  inherit fetchurl lib buildFirefoxXpiAddon;
  stdenv = stdenvNoCC;
}
