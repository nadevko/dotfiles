let
  pkgs = import <nixpkgs> { system = builtins.currentSystem; };
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages = builtins.mapAttrs (name: value: callPackage ./nix/${name} value) {
    nanorc = { };
    mkNanorcBundle = { };
  };
in {
  modules = {
    nixos = import ./nixos/lib;
    home-manager = import ./home-manager/lib;
  };
} // packages
