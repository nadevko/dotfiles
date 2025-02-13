{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.nixpkgs;
in
{
  _class = "nixos";

  options.nixpkgs.compat = mkEnableOption "overlays compatibility for tools";

  config.nix.nixPath = mkIf cfg.compat (
    options.nix.nixPath.default ++ [ "nixpkgs-overlays=${../nixpkgs-compat}" ]
  );
}
