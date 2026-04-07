{ config, pkgs, ... }:
{
  imports = [ ../../nixosModules/known-git-hosts ];

  environment.systemPackages = [ pkgs.cloudflared ];

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
  programs.ssh.startAgent = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
