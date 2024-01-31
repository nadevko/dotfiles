let pkgs = import <nixpkgs> { system = builtins.currentSystem; };
in { nanorc = pkgs.callPackage ./nix/nanorc.nix { }; }
