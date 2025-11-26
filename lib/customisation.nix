final: prev:
let
  inherit (builtins) foldl' isString isList;
in
{
  generateMissingPackagesFromList =
    generator:
    foldl' (
      acc: ext:
      (
        if isString ext then
          generator [ ext ]
        else if isList ext then
          ext
        else
          [ ext ]
      )
      ++ acc
    ) [ ];
}
