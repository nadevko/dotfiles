{ ... }: {
  imports = builtins.map (module: ./${module}.nix) [
    "desktop"
    "home-manager"
    "nur"
    "programs"
    "unfree"
    "virtualisation"
  ];
}
