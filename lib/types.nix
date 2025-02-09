final: prev: with (if builtins.hasAttr "lib" prev then prev.lib else prev); {
  file = types.submodule (
    {
      name,
      config,
      ...
    }:
    {
      options = {
        enable = mkEnableOption "generation of this file";

        target = mkOption {
          default = /${name};
          example = /etc/file.txt;
          description = "Representation of ${/${target}/${name}} file.";
          type = with types; nullOr path;
        };
        source = mkOption {
          default = "";
          example = /etc/some.txt;
          description = ''
            Content of the file. It can be plain text, a path to a file with
            required content, or a directory (an attribute set of file
            definitions).
          '';
          type =
            with types;
            oneOf [
              (attrsOf (final.lib.types.file /${target}/.))
              lines
              path
            ];
        };

        # mode = mkOption {
        #   default = "store";
        #   example = "symlink";
        #   description = ''
        #     Set mode of the source file creation. In symlink mode will be
        #     created link to provided source path, store mode creates symlink
        #     to nix story copy of source, copy mode creates new file with
        #     content of source in target destination. If file source is text
        #     literal, symlink mode can't be used. Inside directory can be used
        #     only store type.
        #   '';
        #   type = types.oneOf [
        #     "symlink"
        #     "store"
        #     "copy"
        #   ];
        # };
        executable = mkOption {
          default = null;
          example = true;
          description = ''
            Sets the executable bit of the file. If the source is a path, the
            executable bit is copied from the source file by default.
          '';
          type = with types; nullOr bool;
        };

        # onChange = mkOption {
        #   type = final.lib.types.file;
        #   default = "";
        #   description = ''
        #     Shell script to run when the file has changed between generations.
        #     The script will be run after the new files have been linked into
        #     place.
        #   '';
        # };
      };

      config = {
        assertions = [
          {
            assertion = !isAttrs config.source;
            message = "Creation of directories are not implemented";
          }
        ];
        source =
          if isString config.source then
            prev.writeTextFile {
              inherit name;
              text = config.source;
              executable = config.executable == true;
              destination = config.target;
            }
          else
            config.source;
      };
    }
  );
}
