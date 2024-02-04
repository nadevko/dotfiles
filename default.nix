let pkgs = import <nixpkgs> { system = builtins.currentSystem; };
in (builtins.mapAttrs (name: value: pkgs.callPackage ./nix/${name} value) {
  nanorc = { };
})
