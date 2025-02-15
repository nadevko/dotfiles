with builtins;
attrs:
foldl' (a: b: "${a}${b}") "" (
  attrValues (mapAttrs (k: v: "${v} ${k};") attrs)
)
