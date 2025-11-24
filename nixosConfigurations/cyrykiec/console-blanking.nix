{ pkgs, ... }:
{
  boot.kernelParams = [ "consoleblank=300" ];

  services.logind = {
    lidSwitch = "lock";
    extraConfig = ''
      LockCommand=${pkgs.physlock}/bin/physlock
    '';
  };
}
