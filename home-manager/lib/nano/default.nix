{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.nano;
  colors = with types;
    either (strMatching "^#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$") (enum [
      "red"
      "green"
      "blue"
      "magenta"
      "yellow"
      "cyan"
      "white"
      "black"
      "grey"
      "pink"
      "purple"
      "mauve"
      "lagoon"
      "mint"
      "lime"
      "peach"
      "orange"
      "latte"
      "rosy"
      "beet"
      "plum"
      "sea"
      "sky"
      "slate"
      "teal"
      "sage"
      "brown"
      "ocher"
      "sand"
      "tawny"
      "brick"
      "crimson"
      "normal"
    ]);
  mkFlagOption = name: description:
    mkOption {
      type = with types; nullOr bool;
      default = null;
      example = true;
      description = description;
      apply = value:
        if isNull value then
          ""
        else ''
          ${if !value then "un" else ""}set ${name}
        '';
    };
  mkTypeOption = type: example: name: description:
    mkOption {
      type = types.nullOr type;
      default = null;
      example = example;
      description = description;
      apply = value:
        if isNull value then
          ""
        else ''
          set ${name} "${toString value}"
        '';
    };
  mkColorOption = name: description:
    mkOption {
      type = with types;
        submodule {
          options = {
            bold = mkOption {
              type = bool;
              default = false;
              apply = value: if value then "bold," else "";
            };
            italic = mkOption {
              type = bool;
              default = false;
              apply = value: if value then "italic," else "";
            };
            fgcolor = mkOption {
              type = nullOr colors;
              default = null;
              apply = value:
                if isNull value then
                  ""
                else if isList value then
                  "#${concatStrings (map (value: toString value) value)}"
                else
                  value;
            };
            bgcolor = mkOption {
              type = nullOr colors;
              default = null;
              apply = value: if isNull value then "" else value;
            };
          };
        };
      example = {
        bold = true;
        fgcolor = "pink";
        bgcolor = "#4FF";
      };
      default = { };
      description = description;
      apply = value:
        if value.fgcolor == "" && value.bgcolor == "" then
          ""
        else ''
          set ${name} ${value.bold}${value.italic}${value.fgcolor}${
            if value.fgcolor != "" && value.bgcolor != "" then "," else ""
          }${value.bgcolor}
        '';
    };
  paths = import ./paths.nix;
in {
  options.programs.nano = {
    enable = mkEnableOption "nano";
    package = mkPackageOption pkgs "nano" { };
    config = (mapAttrs mkFlagOption (import ./flags.nix))
      // (mapAttrs (mkTypeOption types.str "<[({})]>") (import ./chars.nix))
      // (mapAttrs (mkTypeOption types.int 80) (import ./nums.nix))
      // (mapAttrs (mkTypeOption types.path (xdg.cacheHome + "/nano/nanorc"))
        paths) // (mapAttrs mkColorOption (import ./colors.nix));
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = lib.mdDoc "Extra contents for nanorc";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."nano/nanorc" = {
      text = "${concatStrings (attrValues cfg.config)}${cfg.extraConfig}";
      onChange = ''
        ${concatStrings (attrValues (mapAttrs (name: value:
          if value == "" || !hasAttr name paths then
            ""
          else ''
            mkdir --parent ${removePrefix "set ${name} " value}
          '') cfg.config))}
      '';
    };
  };
}
