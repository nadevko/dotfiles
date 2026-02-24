{
  config,
  pkgs,
  lib,
  kasumi,
  ...
}:
let
  cfg = config.qt.kvantum;
in
{
  options.qt.kvantum = {
    name = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      example = "KvLibadwaita";
      description = "Theme package to be used by kvantum theming engine.";
    };

    package = lib.mkOption {
      type = with lib.types; nullOr package;
      default = if cfg.name == null then null else pkgs.${cfg.name} or null;
      example = lib.literalExpression "pkgs.KvLibadwaita";
      description = ''
        Theme to use for Qt5/Qt6 applications by kvantum theming engine.
        Auto-detected from `qt.kvantum.name` if possible.
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      example = {
        General = {
          translucent_windows = true;
          reduce_window_opacity = 13;
          reduce_menu_opacity = 13;
        };
        Hacks = {
          transparent_dolphin_view = true;
        };
      };
      description = ''
        Extra configuration for the kvantum theme engine.
        See the Kvantum documentation for available options:
        <https://github.com/tsujan/Kvantum/blob/master/Kvantum/doc/Theme-Config>

        All group names (top-level attributes) must be in `TitleCase`.
      '';
    };
  };

  config.xdg.configFile = lib.mkIf (cfg.name != null) {
    "Kvantum/${cfg.name}".source = "${cfg.package}/share/Kvantum/${cfg.name}";
    "Kvantum/kvantum.kvconfig".text =
      lib.generators.toINI { } <| kasumi.lib.pointwiser { General.theme = cfg.name; } cfg.extraConfig;
  };
}
