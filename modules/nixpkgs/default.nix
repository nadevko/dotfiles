{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.nixpkgs;
  maintainer = import ../.. {
    pkgs =
      pkgs.extend
        (import ../.. {
          inherit pkgs;
        }).overlays.maintainer;
  };
in
{
  _class = "nixos";

  options.nixpkgs = {
    reposPath = mkOption {
      default = null;
      example = ./repos.nix;
      description = ''
        The value of this option is a attrset where name used as id of
        repository in options; path is file with function that accepts current
        pkgs as argument (like in nixpkgs) and returns their overrides;
        description is pretty name of the repository.

        {
        	name = {
        		path = ./repo.nix;
        		description = "beautiful name";
        	};
        }
      '';
      type = with types; nullOr path;
    };
    repos = mkOption {
      description = ''
        Setting repository id to true adds its packages to packageOverrides and
        provides them as module arguments. In the first case all packages are
        prefixed with repository id.
      '';
      type = types.submodule {
        options = mapAttrs (
          k: v:
          mkOption {
            inherit (v) description;
            default = false;
            example = true;
            type = types.bool;
            apply = val: if val then pkgs: import v.path { inherit pkgs; } else null;
          }
        ) (import cfg.reposPath);
      };
      apply = repos: pkgs: mapAttrs (k: v: v pkgs) (filterAttrs (k: v: v != null) repos);
    };
  };

  config = mkIf (cfg.reposPath != null) {
    nixpkgs.config.packageOverrides = cfg.repos;
    _module.args = cfg.repos pkgs;
  };
}
