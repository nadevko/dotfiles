{
  pkgs ? import <nixpkgs> { },
}:
let
  loadDir =
    f: dir:
    pkgs.lib.mapAttrs' (k: v: {
      name = pkgs.lib.removeSuffix ".nix" k;
      value = f /${dir}/${k} v;
    }) (builtins.readDir dir);
in
(loadDir (dir: v: pkgs.callPackage (import v) { }) ./pkgs)
// (pkgs.lib.listToAttrs (
  map
    (x: {
      name = x;
      value = loadDir (dir: v: import dir) ./${x};
    })
    [
      "lib"
      "modules"
      "overlays"
    ]
))
