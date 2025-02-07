{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs.lib) fix;
  inherit (trivial) loadDir;
  trivial = fix (import ./lib/trivial.nix) pkgs.lib;
in
(loadDir (dir: v: pkgs.callPackage (import v) { }) ./pkgs)
// rec {
  lib = fix overlays.lib pkgs.lib;
  modules = loadDir (dir: v: import dir) ./modules;
  overlays = loadDir (dir: v: import dir trivial) ./overlays;
}
