{ pkgs, ... }:
{
  boot.kernelParams = [ "consoleblank=300" ];

  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    LockCommand = "${pkgs.physlock}/bin/physlock";
  };
}
