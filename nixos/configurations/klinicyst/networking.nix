{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking = {
    hostName = "klinicyst";
    networkmanager.enable = true;
    firewall.enable = false;
  };
  security.rtkit.enable = true;

  services = {
    openssh = {
      enable = true;
      openFirewall = false;
      settings.UseDns = true;
    };
    zapret = {
      enable = true;
      whitelist = [
        "2ch.hk"
        "studfile.net"
      ];
      params = [ "--dpi-desync=disorder2" ];
    };
    wg-netmanager.enable = true;
    cloudflare-warp.enable = true;
  };
  environment.systemPackages = lib.mkIf config.services.cloudflare-warp.enable (
    with pkgs; [ desktop-file-utils ]
  );
}
