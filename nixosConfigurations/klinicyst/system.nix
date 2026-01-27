{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.hardware-by-laptop-Lenovo-IdeaPad-5-Pro-14ARH7-82SJ004K
    inputs.self.nixosModules.agenix
  ];

  system = {
    stateVersion = "24.11";
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = true;
  };
  i18n = {
    defaultLocale = "be_BY.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };
  time.timeZone = "Europe/Minsk";

  nix = {
    settings = {
      experimental-features = [
        "cgroups"
        "fetch-tree"
        "flakes"
        "nix-command"
      ];
      trusted-users = [ "@wheel" ];
      fallback = true;
      use-xdg-base-directories = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "3h";
    };
    optimise = {
      automatic = true;
      dates = [ "monthly" ];
      randomizedDelaySec = "3h";
    };
    channel.enable = false;
  };
  nixpkgs = {
    flake.setNixPath = true;
    hostPlatform = "x86_64-linux";
  };
  programs.nix-ld.enable = true;
}
