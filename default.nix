let
  pkgs = import <nixpkgs> { system = builtins.currentSystem; };
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages = builtins.mapAttrs (name: value: callPackage ./nix/${name} value) {
    nanorc = { };
  };
in packages
