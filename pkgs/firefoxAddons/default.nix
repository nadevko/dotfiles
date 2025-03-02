{
  inputs,
  system,
  fetchurl,
  lib,
  stdenvNoCC,
  ...
}:
import ./_generated.nix {
  inherit fetchurl lib;
  stdenv = stdenvNoCC;
  buildFirefoxXpiAddon = inputs.self.packages.${system}.buildFirefoxXpiAddon.override;
}
