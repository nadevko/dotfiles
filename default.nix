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
    isAttrs
    zipAttrsWith
    length
    elemAt
    head
    ;
  inherit (attrsets) loadDir;
  fix =
    f:
    let
      x = f x;
    in
    x;
  recursiveUpdateUntil =
    pred: lhs: rhs:
    let
      f =
        attrPath:
        zipAttrsWith (
          n: values:
          let
            here = attrPath ++ [ n ];
          in
          if length values == 1 || pred here (elemAt values 1) (head values) then
            head values
          else
            f here values
        );
    in
    f [ ] [ rhs lhs ];
  recursiveUpdate =
    lhs: rhs:
    recursiveUpdateUntil (
      path: lhs: rhs:
      !(isAttrs lhs && isAttrs rhs)
    ) lhs rhs;

  attrsets = fix (import ./lib/attrsets.nix) {
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
    maintainers =
      final: prev:
      import ./overlay.nix final prev // { lib = recursiveUpdate prev.lib (fix libOverlay prev); };
  } // loadDir (dir: import dir) ./overlays;
}
