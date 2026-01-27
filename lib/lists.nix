final: prev:
let
  inherit (builtins) isString partition;
in
{
  generateMissingVscodeExtensions =
    generator: list:
    let
      inherit (partition isString list) right wrong;
    in
    (generator right) ++ wrong;
}
