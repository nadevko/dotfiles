{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (builtins)
    stringLength
    substring
    listToAttrs
    attrNames
    filter
    ;
  inherit (trivial) loadDir;
  fix =
    f:
    let
      x = f x;
    in
    x;

  trivial = fix (import ./lib/trivial.nix) {
    lib = builtins // {
      mapAttrs' = f: set: listToAttrs (map (attr: f attr set.${attr}) (attrNames set));
      removeSuffix =
        suffix: str:
        let
          sufLen = stringLength suffix;
          sLen = stringLength str;
        in
        if sufLen <= sLen && suffix == substring (sLen - sufLen) sufLen str then
          substring 0 (sLen - sufLen) str
        else
          str;
      filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
      hasSuffix =
        suffix: content:
        let
          lenContent = stringLength content;
          lenSuffix = stringLength suffix;
        in
        lenContent >= lenSuffix && substring (lenContent - lenSuffix) lenContent content == suffix;
    };
  };

  libOverlay = final: prev: loadDir (dir: import dir final prev) ./lib;
in
(loadDir (dir: pkgs.callPackage dir { }) ./pkgs)
// {
  lib = fix libOverlay pkgs;
  modules = loadDir (dir: import dir) ./modules;
  overlays = {
    lib = libOverlay;
  } // loadDir (dir: import dir) ./overlays;
}
