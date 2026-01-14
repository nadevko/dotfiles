{ lib, buildFirefoxXpiAddon }:
import ./.generated.nix {
  inherit lib buildFirefoxXpiAddon;
  fetchurl = null;
  stdenv = null;
}
// {
  recurseForDerivations = true;
}
