{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.secrix;
  maintainer = import ../. { inherit pkgs; };
  secrix = (maintainer.lib.trivial.getFlake <secrix>).defaultNix;
  package = pkgs.callPackage ../pkgs/secrix.nix {
    hostName = config.networking.hostName;
    inherit cfg;
  };
in
{
  _class = "nixos";
  imports = [ secrix.nixosModules.secrix ];

  config.environment.systemPackages = lib.mkIf (cfg.services != { } || cfg.system.secrets != { }) [
    package
  ];
}
