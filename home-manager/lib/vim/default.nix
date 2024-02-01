{ config, lib, pkgs, ... }:
with lib;
let cfg = config.programs.vim;
in {
  disabledModules = [ <home-manager/modules/programs/vim.nix> ];
  options.programs.vim = {
    enable = mkEnableOption "vim";
    package = mkPackageOption pkgs "vim" {
      default = pkgs.vim-full;
      example = pkgs.vim_configurable;
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
  };
  config = mkIf cfg.enable {
    home.packages =
      [ (cfg.package.customize { vimrcConfig.customRC = cfg.extraConfig; }) ];
  };
}
