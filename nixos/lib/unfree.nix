{ config, lib, ... }:
with lib; {
  options.nixpkgs.unfree = {
    policy = mkOption {
      type = types.enum [ "allow" "restrict" "deny" "disable" ];
      default = "restrict";
      example = "deny";
      description = mdDoc ''
        Attitude towards non-free software. "allow" allows them to be
        installed, "deny" forbids and "restrict" limits them to listed in
        "nixpkgs.unfree.packages". Or you can "disable" this option.
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

  config.nixpkgs = let
    cfg = config.nixpkgs.unfree;
    mkUnfreeAllowed = prog: pkgs:
      mkIf (config.programs."${prog}".enable) { unfree.packages = pkgs; };
  in mkMerge [
    (mkIf (cfg.policy == "deny") { config.allowUnfree = false; })
    (mkIf (cfg.policy == "allow") { config.allowUnfree = true; })
    (mkIf (cfg.policy == "restrict") (mkMerge [
      (mkUnfreeAllowed "steam" [ "steam" "steam-original" "steam-run" ])
      {
        config.allowUnfreePredicate = pkg:
          builtins.elem (getName pkg) cfg.packages;
      }
    ]))
  ];
}
