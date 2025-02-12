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
  inherit
    (pkgs.runCommand config.nixpkgs.release { preferLocalBuild = true; } ''
      if [[ -f /var/lib/nixos/did-channel-init ]]; then
      	echo 1 > $out
      else
      	echo 0 > $out
      fi
    '')
    out
    ;
  channels = import ./channels.nix "${cfg.release}${optionalString cfg.small "-small"}";
in
{
  _class = "nixos";

  options.nixpkgs = {
    compat = mkEnableOption "overlays compatibility for tools";
    nix-doc = mkEnableOption "nix-doc";

    channelInit = mkEnableOption "setup channels" // {
      default = readFile out == "1";
    };
    release = mkOption {
      default = "unstable";
      example = "24.11";
      description = "The NixOS release or unstable.";
    };
    small = mkEnableOption "small channels";
  };

  config = {
    system.activationScripts = mkMerge [
      (mkIf cfg.channelInit ''
        if [[ ! -f /var/lib/nixos/did-channel-init ]]; then
        	for i in${
           builtins.foldl' (a: b: "${a} '${channels.${b}} ${b}'") "" (builtins.attrNames channels)
         }; do
        	  nix-channel --add $i
        	done
        	touch /var/lib/nixos/did-channel-init
        fi
      '')
    ];
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
