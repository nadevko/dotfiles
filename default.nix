let pkgs = import <nixpkgs> { system = builtins.currentSystem; };
in { hello-world = pkgs.callPackage ./nix/hello-world.nix { }; }
