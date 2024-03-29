{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.vim;
  mkPluginsOption = description:
    mkOption {
      type = with types; listOf (either path package);
      default = [ ];
      example = [ pkgs.vimPlugins.vim-nix ];
      inherit description;
    };
in {
  disabledModules = [ <home-manager/modules/programs/vim.nix> ];
  options.programs.vim = {
    enable = mkEnableOption "vim";
    package = mkPackageOption pkgs "vim" {
      default = "vim-full";
      example = "vim_configurable";
    };
    plugins = {
      start = mkPluginsOption "List of plugins to load at startup";
      opt = mkPluginsOption "List of plugins to load at call";
      autoload = mkOption {
        type = with types; attrsOf (listOf (str));
        default = { };
        example = { nix = [ "vim-nix" ]; };
        description =
          "Mapping filetypes to plugins that will be loaded when they are opened";
      };
    };
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      example = ''
        set nocompatible
        set nobackup
      '';
      description = "Extra contents for vimrc";
    };
    extraGuiConfig = mkOption {
      type = types.lines;
      default = "";
      example = ''
        set nocompatible
        set nobackup
      '';
      description = "Extra contents for gvimrc";
    };
  };
  config = let
    autoload = flatten (mapAttrsToList (name: list:
      map (value: ''
        autocmd FileType ${name} :packadd ${value}
      '') list) cfg.plugins.autoload);
  in mkIf cfg.enable {
    home.packages = [
      (cfg.package.customize {
        vimrcConfig = {
          beforePlugins = ''
            " configuration generated by NIX
            ${
              optionalString (cfg.extraConfig != "" || cfg.plugins != { }) ''
                set nocompatible
              ''
            }${
              optionalString (autoload != [ ]) ''
                filetype on
              ''
            }'';
          packages.home-manager = {
            start = cfg.plugins.start;
            opt = cfg.plugins.opt;
          };
          customRC = "${concatStrings autoload}${cfg.extraConfig}";
        };
        gvimrcFile = cfg.extraGuiConfig;
      })
    ];
  };
}
