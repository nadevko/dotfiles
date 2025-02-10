final: prev:
with prev.lib;
let
  overlays = (import <nixpkgs/nixos> { }).config.nixpkgs.overlays;
in
foldl' (flip extends) (_: prev) overlays final
