{ config, lib, ... }:
{
  options.programs.gnome-shell.extensions = lib.mkOption {
    type = lib.types.listOf (
      lib.types.submodule {
        options.settings = lib.mkOption {
          type = with lib.types; attrsOf (attrsOf lib.hm.types.gvariant);
          default = { };
          description = ''
            Settings for GNOME Shell extensions.
            Each extension can have its own settings, which are specified
            as a nested attribute set under the extension's ID.
          '';
        };
      }
    );
  };
  config.dconf.settings = lib.mkIf (config.programs.gnome-shell.enable) (
    lib.mergeAttrsList (builtins.catAttrs "settings" config.programs.gnome-shell.extensions)
  );
}
