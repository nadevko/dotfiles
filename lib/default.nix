{ nix4vscode, ... }:
let
  inherit (builtins) foldl' isString isList;
in
rec {
  GetVscodeExtensions =
    system: decorators: version:
    GetVscodeExtensionsWith (nix4vscode.lib.${system}.forVscodeExtVersion decorators version);

  GetVscodeExtensionsWith =
    getter:
    foldl' (
      acc: ext:
      acc
      ++ (
        if isString ext then
          getter [ ext ]
        else if isList ext then
          ext
        else
          [ ext ]
      )
    ) [ ];
}
