{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.agenix.nixosModules.default ];

  options.age.secretsFile = {
    root = lib.mkOption {
      type = with lib.types; coercedTo path toString str;
      description = "Absolute secrets path";
    };
    path = lib.mkOption {
      type = lib.types.str;
      description = "R `secrets.nix`";
      default = "${config.age.secretsFile.root}/secrets.nix";
    };
    content = lib.mkOption {
      type =
        with lib.types;
        attrsOf (submodule {
          options = {
            name = lib.mkOption { type = str; };
            nixosConfigurations = lib.mkOption { type = listOf str; };
            publicKeys = lib.mkOption { type = listOf str; };
          };
        });
      default =
        if builtins.pathExists config.age.secretsFile.path then import config.age.secretsFile.path else { };
    };
  };

  config.age.secrets = lib.pipe config.age.secretsFile.content [
    (lib.filterAttrs (_: secret: builtins.elem config.networking.hostName secret.nixosConfigurations))
    (lib.mapAttrs' (
      path: secret: lib.nameValuePair secret.name { file = "${config.age.secretsFile.root}/${path}"; }
    ))
  ];
}
