final: prev:
let
  inherit (builtins) foldl' isString isList;
in
rec {
  GetVscodeExtensions =
    forVscodeExtVersion: decorators: version:
    GetVscodeExtensionsWith (forVscodeExtVersion decorators version);

  GetVscodeExtensionsWith =
    getter:
    foldl' (
      acc: ext:
      (
        if isString ext then
          getter [ ext ]
        else if isList ext then
          ext
        else
          [ ext ]
      )
      ++ acc
    ) [ ];
}
