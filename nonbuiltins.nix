let
  fix =
    f:
    let
      x = f x;
    in
    x;
in
fix (
  x:
  with x;
  builtins
  // {
    inherit fix;
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
    filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
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
    hasSuffix =
      suffix: content:
      let
        lenContent = stringLength content;
        lenSuffix = stringLength suffix;
      in
      lenContent >= lenSuffix && substring (lenContent - lenSuffix) lenContent content == suffix;

    attrsets = fix (import ./lib/attrsets.nix) x;
    inherit (attrsets) loadDir;
    libOverlay = path: final: prev: loadDir (dir: import dir final prev) path;
  }
)
