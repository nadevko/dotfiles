final: prev: with (if builtins.hasAttr "lib" prev then prev.lib else prev); {
  loadDir =
    f: dir:
    mapAttrs' (k: v: {
      name = removeSuffix ".nix" k;
      value = f /${dir}/${k};
    }) (filterAttrs (k: v: hasSuffix ".nix" k || v == "directory") (readDir dir));
}
