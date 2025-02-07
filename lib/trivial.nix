final: prev: with prev; {
  loadDir =
    f: dir:
    mapAttrs' (k: v: {
      name = removeSuffix ".nix" k;
      value = f /${dir}/${k};
    }) (readDir dir);
}
