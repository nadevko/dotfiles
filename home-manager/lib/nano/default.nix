{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.nano;
  colors = with types;
    either (strMatching "^#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$")
    (enum (import ./colornames.nix));
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
      type = types.submodule {
        options = {
          bold = mkOption {
            type = types.bool;
            default = false;
            apply = value: if value then "bold," else "";
          };
          italic = mkOption {
            type = types.bool;
            default = false;
            apply = value: if value then "italic," else "";
          };
          fgcolor = mkOption {
            type = types.nullOr colors;
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
            type = types.nullOr colors;
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
    bindings = mkOption {
      type = with types;
        listOf (submodule {
          options = {
            key = mkOption {
              type = strMatching
                "^(\\^([A-Z@\\\\\\^_]|]|Space)|M-([ -Z\\\\-~]|Space)|Sh-M-[A-Z]|F(1?[1-9]|10|2[0-4])|Ins|Del)$";
            };
            function = mkOption {
              type =
                either str (enum ((import ./functions.nix) ++ [ "unbind" ]));
            };
            menu = mkOption { type = enum (import ./menus.nix); };
          };
        });
      example = {
        key = "^Z";
        function = "unbind";
        menu = "help";
      };
      description =
        "Set key to do function in the menu. 'unbind' to do nothing.";
      apply = list:
        map (value: ''
          ${if value.function == "unbind" then
            "unbind ${value.key} ${value.menu}"
          else
            "bind ${value.key} ${value.function} ${value.menu}"}
        '') list;
    };
    includes = mkOption {
      type = with types; listOf (package);
      default = [ ];
      example = [ pkgs.nano pkgs.nanorc ];
    };
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = lib.mdDoc "Extra contents for nanorc";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."nano/nanorc" = {
      text = "${concatStrings ((attrValues cfg.config) ++ cfg.bindings)}${
          concatStrings (map (value:
            if value == cfg.package then ''
              include "${value}/share/nano/*.nanorc"
              include "${value}/share/nano/extra/*.nanorc"
            '' else if value == pkgs.nanorc then ''
              include "${value}/share/*.nanorc"
            '' else ''
              include "${value}/*.nanorc"
            '') cfg.includes)
        }${cfg.extraConfig}";
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
