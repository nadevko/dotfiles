{ config, lib, ... }:
with lib; {
  options.nixpkgs.unfree = {
    enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = mdDoc "Allow to use unfree software.";
    };
    policy = mkOption {
      type = types.enum [ "allow" "restrict" "specify" ];
      default = "restrict";
      example = "allow";
      description = mdDoc ''
        Attitude towards non-free software. "allow" allows them all to be
        installed, when "specify" limits to listed in
        "nixpkgs.unfree.packages". "restrict" acts like "specify", but
        automatically adds all enabled unfree "programs.$''${name}".
      '';
    };
    packages = mkOption {
      type = with types; listOf str;
      default = [ ];
      example = [ "steam" "steam-original" "steam-run" ];
      description = mdDoc ''
        List of allowed non-free packages. Non-free software that enabled using
        'program.*.enable' are added to the list automatically.
      '';
    };
  };

  config = let
    cfg = config.nixpkgs.unfree;
    mkUnfreeAllowed = prog: pkgs:
      mkIf (config.programs.${prog}.enable) { unfree.packages = pkgs; };
  in mkMerge [
    (mkIf (!cfg.enable) {
      nixpkgs.config.allowUnfree = false;
      hardware.enableRedistributableFirmware = false;
    })
    (mkIf (cfg.enable) {
      nixpkgs = mkMerge [
        (mkIf (cfg.policy == "allow") { config.allowUnfree = true; })
        (mkIf (cfg.policy == "restrict") (mkMerge [
          (mkUnfreeAllowed "steam" [ "steam" "steam-original" "steam-run" ])
        ]))
        (mkIf (cfg.policy != "allow") {
          config.allowUnfree = false;
          config.allowUnfreePredicate = pkg:
            builtins.elem (getName pkg) cfg.packages;
        })
      ];
      hardware.enableRedistributableFirmware = true;
    })
  ];
}
