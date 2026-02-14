{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:
let
  cfg = config.programs.command-not-found;
  commandNotFound = pkgs.replaceVarsWith {
    name = "command-not-found";
    dir = "bin";
    src = nixpkgs + "/nixos/modules/programs/command-not-found/command-not-found.pl";
    isExecutable = true;
    replacements = {
      inherit (cfg) dbPath;
      perl = pkgs.perl.withPackages (p: [
        p.DBDSQLite
        p.StringShellQuote
      ]);
    };
  };
in
{
  disabledModules = [ "programs/command-not-found/command-not-found.nix" ];

  options.programs.command-not-found = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = ''
        Whether interactive shells should show which Nix package (if
        any) provides a missing command.

        See also nix-index and nix-index-database as an alternative for flakes-based systems.

        Additionally, having the env var NIX_AUTO_RUN set will automatically run the matching package, and with NIX_AUTO_RUN_INTERACTIVE it will confirm the package before running.
      '';
      default = builtins.pathExists cfg.dbPath;
    };
    dbPath = lib.mkOption {
      type = lib.types.path;
      description = ''
        Absolute path to `programs.sqlite`, which contains mappings from binary names to package names.

        If you use the channels release (nixexprs.tar.xz from https://releases.nixos.org),
        this file will be provided by your nixpkgs package set by default.
        In this case, activating a new system generation is likely required to use a different database.

        To use the stateful `programs.sqlite` database, set this option to
        `/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite`.
        If you do so, you can update it with `sudo nix-channels --update`.
      '';
      default = nixpkgs + "/programs.sqlite";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      bash.interactiveShellInit = ''
        command_not_found_handle() {
          '${commandNotFound}/bin/command-not-found' "$@"
        }
      '';
      zsh.interactiveShellInit = ''
        command_not_found_handler() {
          '${commandNotFound}/bin/command-not-found' "$@"
        }
      '';
      fish.interactiveShellInit = ''
        function fish_command_not_found
           "${commandNotFound}/bin/command-not-found" $argv
        end
      '';
    };
    environment.systemPackages = [ commandNotFound ];
  };
}
