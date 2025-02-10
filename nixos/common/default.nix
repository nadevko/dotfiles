{
  options,
  pkgs,
  lib,
  ...
}:
let
  maintainer = import ../.. { inherit pkgs; };
in
{
  _class = "nixos";
  imports = lib.attrValues maintainer.modules;

  config = {
    nixpkgs.overlays = lib.attrValues maintainer.overlays;
    nix.nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=${../../nixpkgs-compat}" ];
  };
}
