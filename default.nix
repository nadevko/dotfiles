{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (builtins)
    stringLength
    substring
    listToAttrs
    attrNames
    ;
  inherit (trivial) loadDir;
  mapAttrs' = f: set: listToAttrs (map (attr: f attr set.${attr}) (attrNames set));
  removeSuffix =
    suffix: str:
    let
      sufLen = stringLength suffix;
      sLen = stringLength str;
    in
    if sufLen > sLen then
      str
    else if suffix == substring (sLen - sufLen) sufLen str then
      substring 0 (sLen - sufLen) str
    else
      str;
  fix =
    f:
    let
      x = f x;
    in
    x;
  trivial = fix (import ./lib/trivial.nix) (
    builtins
    // {
      inherit mapAttrs' removeSuffix;
    }
  );
  libOverlay = final: prev: loadDir (dir: import dir final prev) ./lib;
in
(loadDir (dir: pkgs.callPackage dir { }) ./pkgs)
// {
  lib = fix libOverlay pkgs.lib;
  modules = loadDir (dir: import dir) ./modules;
  overlays = {
    lib = libOverlay;
  } // loadDir (dir: import dir) ./overlays;
}
