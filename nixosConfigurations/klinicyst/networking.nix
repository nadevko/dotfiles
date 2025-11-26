{ config, ... }:
{
  networking = {
    hostName = "klinicyst";
    networkmanager.enable = true;
    firewall.enable = true;
  };
  security.rtkit.enable = true;

  services = {
    openssh = {
      enable = true;
      openFirewall = false;
      settings.UseDns = true;
    };
    xray = {
      enable = true;
      settingsFile = config.age.secrets.xray-klinicyst.path;
    };
    cloudflared = {
      enable = true;
      certificateFile = config.age.secrets.cloudflared-klinicyst.path;
    };
    cloudflare-warp.enable = true;
  };
}
