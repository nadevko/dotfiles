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
    release = mkOption {
      default = "unstable";
      example = "24.11";
      description = "The NixOS release or unstable.";
    };
    small = mkEnableOption "small channels";
    compat = mkEnableOption "overlays compatibility for tools";
    setupChannels = mkEnableOption "setup channels";
    nix-doc = mkEnableOption "nix-doc";
  };

  config = {
    system.activationScripts =
      let
        channels = import ./channels.nix "${cfg.release}${mkIf cfg.small "-small"}";
      in
      [
        (mkIf cfg.setupChannels ''
          if [[ ! -f /etc/nixos/.channel-setup ]]; then
          	for i in${
             builtins.foldl' (a: b: "${a} '${channels.${b}} ${b}'") "" (builtins.attrNames channels)
           }; do
          	  nix-channel --add $i
          	done
          	touch /etc/nixos/.channel-setup
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
