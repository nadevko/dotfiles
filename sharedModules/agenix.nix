_class:
let
  isNixos = _class == "nixos";
in
if !isNixos && _class != "homeManager" then
  { }
else
  {
    config,
    lib,
    self,
    agenix,
    kasumi,
    ...
  }:
  let
    inherit (builtins) elem;

    inherit (lib) types;
    inherit (lib.attrsets) filterAttrs mapAttrs';
    inherit (lib.options) mkOption mkEnableOption;

    inherit (kasumi.lib.attrsets) pair;

    cfg = config.age.secretsNix;
  in
  {
    inherit _class;
    imports = [ agenix.${if isNixos then "nixosModules" else "homeManagerModules"}.default ];

    options.age.secretsNix = {
      enable = mkEnableOption "secrets.nix autoimport" // {
        default = true;
      };
      root = mkOption {
        type = with types; coercedTo path toString str;
        description = "Absolute secrets path";
        default = self;
      };
      path = mkOption {
        type = types.str;
        description = "Path to `secrets.nix` file relative to `root`";
        default = "secrets.nix";
      };
    };

    config.age.secrets =
      cfg.root + "/${cfg.path}"
      |> import
      |> filterAttrs (
        if isNixos then
          _: secret: elem config.networking.hostName (secret.nixosConfigurations or [ ])
        else
          _: secret: elem config.home.username (secret.homeConfigurations or [ ])
      )
      |> mapAttrs' (abs: secret: pair secret.name { file = cfg.root + "/${abs}"; });
  }
