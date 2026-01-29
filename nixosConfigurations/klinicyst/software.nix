{ pkgs, lib, ... }:
{
  services.postgresql = {
    enable = true;
    authentication = lib.mkOverride 10 ''
      local all all peer
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };
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
  };
  environment.variables.PROTON_ENABLE_WAYLAND = 1;
}
