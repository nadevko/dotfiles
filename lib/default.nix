{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  trivial ? import ./trivial.nix lib,
}:
(lib.mapAttrs (k: v: v lib) (
  trivial.loadDirWithout [
    "default.nix"
    "trivial.nix"
  ] ./.
))
// {
  inherit trivial;
}
