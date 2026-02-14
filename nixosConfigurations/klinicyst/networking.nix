{ config, pkgs, ... }:
{
  imports = [ ../../nixosModules/common-ssh-hosts.nix ];

  networking = {
    hostName = "klinicyst";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
    firewall.enable = true;
  };
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    network.wait-online.enable = false;
    packages = with pkgs; [ riseup-vpn ];
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

  environment.systemPackages = with pkgs; [ riseup-vpn ];
}
