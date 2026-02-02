{
  imports = [
    ../../nixosModules/agenix.nix
    ../../nixosModules/pure-nix.nix
    ../../nixosModules/hardware/by-laptop/Lenovo/IdeaPad-5-Pro/14ARH7-82SJ004K.nix
  ];

  system.stateVersion = "24.11";
  i18n = {
    defaultLocale = "be_BY.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };
  time.timeZone = "Europe/Minsk";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    randomizedDelaySec = "3h";
    options = "--delete-older-than 7d";
  };
  programs.nix-ld.enable = true;
}
