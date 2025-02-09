{
  pkgs ? import <nixpkgs> { },
}:
with (import ./nonbuiltins.nix);
(loadDir (dir: pkgs.callPackage dir { }) ./pkgs)
// {
  lib = fix (libOverlay ./lib) pkgs;
  modules = loadDir (dir: import dir) ./modules;
  overlays = loadDir (dir: import dir) ./overlays;
}
