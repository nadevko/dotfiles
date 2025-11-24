{ pkgs, ... }:
{
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    printing.enable = true;
  };
  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
    dconf.enable = true;
  };
  environment.systemPackages = with pkgs; [
    clapper
    endeavour
    gapless
    papers
  ];
  environment.gnome.excludePackages = with pkgs; [
    decibels
    epiphany
    evince
    gnome-music
    gnome-shell-extensions
    gnome-tour
    gnome-user-docs
    totem
    yelp
  ];
}
