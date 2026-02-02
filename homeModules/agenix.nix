{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (builtins) elem;

  inherit (lib) types;
  inherit (lib.trivial) pipe;
  inherit (lib.attrsets) filterAttrs mapAttrs' nameValuePair;
  inherit (lib.options) mkOption mkEnableOption;

  cfg = config.age.secretsNix;
in
{
  imports = [ inputs.agenix.homeManagerModules.default ];

  options.age.secretsNix = {
    enable = mkEnableOption "secrets.nix autoimport" // {
      default = true;
    };
    root = mkOption {
      type = with types; coercedTo path toString str;
      description = "Absolute secrets path";
      default = inputs.self;
    };
    path = mkOption {
      type = types.str;
      description = "Path to `secrets.nix` file relative to `root`";
      default = "secrets.nix";
    };
  };

  config.age.secrets = pipe "/${cfg.root}/${cfg.path}" [
    import
    (filterAttrs (_: secret: elem config.home.username (secret.homeConfigurations or [ ])))
    (mapAttrs' (abs: secret: nameValuePair secret.name { file = cfg.root + "/${abs}"; }))
  ];
}
