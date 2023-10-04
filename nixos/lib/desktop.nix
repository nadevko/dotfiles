{ pkgs, lib, ... }:
with lib; {
  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
  };
  networking = {
    useDHCP = mkDefault true;
    networkmanager.enable = true;
  };
  programs = {
    dconf.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      home-manager
      gnome.nautilus-python
      gnome.gnome-tweaks
      glib.dev
    ];
    gnome.excludePackages = (with pkgs; [ gnome-tour gnome-photos ])
      ++ (with pkgs.gnome; [ cheese epiphany yelp gnome-maps ]);
  };
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  sound.enable = false;
}
