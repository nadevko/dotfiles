{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.nixpkgs;
  maintainer = import ../. { inherit pkgs; };
in
{
  _class = "nixos";

  options.nixpkgs = {
    compat = mkEnableOption "overlays compatibility for tools";
    repos = mkEnableOption "loading of all nadevko's overlays";
  };

  config = {
    nixpkgs.overlays = mkIf cfg.repos (attrValues maintainer.overlays);
    nix.nixPath = mkIf cfg.compat (
      options.nix.nixPath.default ++ [ "nixpkgs-overlays=${../nixpkgs-compat}" ]
    );
  };
}
