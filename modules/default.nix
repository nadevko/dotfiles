with builtins;
let
  dir = removeAttrs (readDir ./.) [ "default.nix" ];
  attrs = mapAttrs (k: v: ./${k}) dir;
in
attrs // { all = attrValues attrs; }
