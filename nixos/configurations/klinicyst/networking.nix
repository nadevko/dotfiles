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
    cloudflare-warp.enable = true;
  };
}
