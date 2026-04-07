{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    displayManager.autoLogin.user = "nadevko";
    desktopManager.gnome.enable = true;
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
  ];
  environment.gnome.excludePackages = with pkgs; [
    decibels
    epiphany
    gnome-music
    gnome-shell-extensions
    gnome-tour
    gnome-user-docs
    showtime
    yelp
    gnome-system-monitor
    gnome-logs
  ];
}
