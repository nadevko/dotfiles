{
  pkgs ? import <nixpkgs> { },
  dir ? (import ../lib { pkgs.lib = builtins; }).trivial.loadDir ./.,
}:
if dir == { } then { } else pkgs.lib.mapAttrs (k: v: pkgs.callPackage v { }) dir
