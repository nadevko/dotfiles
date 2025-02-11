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

  options.nixpkgs = {
    compat = mkEnableOption "overlays compatibility for tools";
    nix-doc = mkEnableOption "nix-doc";
  };

  config = {
    nix = {
      nixPath = mkIf cfg.compat (
        options.nix.nixPath.default ++ [ "nixpkgs-overlays=${../nixpkgs-compat}" ]
      );
      extraOptions = mkIf cfg.nix-doc ''
        plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
      '';
    };
    environment.systemPackages = mkIf cfg.nix-doc [
      pkgs.nix-doc
    ];
  };
}
