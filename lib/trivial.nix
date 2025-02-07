final: prev: {
  loadDir =
    f: dir:
    prev.mapAttrs' (k: v: {
      name = prev.removeSuffix ".nix" k;
      value = f /${dir}/${k} v;
    }) (builtins.readDir dir);
}
