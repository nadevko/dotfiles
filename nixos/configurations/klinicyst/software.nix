{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
    };
  };
  programs = {
    steam = {
      enable = true;
      protontricks.enable = true;
      extest.enable = true;
    };
    wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = true;
      package = pkgs.wireshark;
    };
    adb.enable = true;
  };
  environment.variables.PROTON_ENABLE_WAYLAND = 1;
}
