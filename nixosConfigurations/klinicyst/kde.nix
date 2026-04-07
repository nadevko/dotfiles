{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
    displayManager.autoLogin.user = "nadevko";
    printing.enable = true;
    libinput.enable = true;
  };
  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = true;
  };
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.akonadi-calendar
    kdePackages.akonadi-contacts
    kdePackages.kdepim-addons
    kdePackages.kwallet-pam
  ];

  security.pam.services.nadevko.kwallet.enable = true;
  security.pam.services.plasma-login-manager.kwallet.enable = true;
}
