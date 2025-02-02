{
  pkgs ? import <nixpkgs> { },
}:
(import ./pkgs { inherit pkgs; })
// {
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;
}
