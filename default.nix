import <nixpkgs> {
  system = builtins.currentSystem;
  overlays = [ (import ./nix/overlay.nix) ];
}
