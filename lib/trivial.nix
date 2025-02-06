lib: with lib; rec {
  loadDir = loadDirWithout [ "default.nix" ];
  loadDirWithout =
    without: root: mapAttrs (k: v: import /${root}/${k}) (removeAttrs (builtins.readDir root) without);
}
