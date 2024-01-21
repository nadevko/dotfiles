{ config, lib, pkgs, ... }:
with lib;
let cfg = config.programs.nano;
in {
  options.programs.nano = {
    enable = mkEnableOption "nano";
    package = mkPackageOption pkgs "nano" { };
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = lib.mdDoc "Extra contents for nanorc";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."nano/nanorc".text = ''
      ${cfg.extraConfig}
    '';
  };
}
