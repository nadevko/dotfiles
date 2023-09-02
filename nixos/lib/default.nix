{ ... }: { imports = builtins.map (module: ./${module}.nix) [ "unfree" ]; }
