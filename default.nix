{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs.lib)
    mapAttrs'
    removeSuffix
    recursiveUpdate
    fix
    ;
  loadDir =
    f: dir:
    mapAttrs' (k: v: {
      name = removeSuffix ".nix" k;
      value = f /${dir}/${k};
    }) (builtins.readDir dir);
  libOverlay =
    final: prev:
    recursiveUpdate {
      trivial = { inherit loadDir; };
    } (loadDir (dir: import dir final prev) ./lib);
in
(loadDir (dir: pkgs.callPackage dir { }) ./pkgs)
// {
  lib = fix libOverlay pkgs.lib;
  modules = loadDir (dir: import dir) ./modules;
  overlays = {
    lib = libOverlay;
  } // loadDir (dir: import dir) ./overlays;
}
