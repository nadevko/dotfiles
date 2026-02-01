{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../../nixosModules/hardware/by-laptop/Lenovo/IdeaPad-5-Pro/14ARH7-82SJ004K.nix
    ../../nixosModules/agenix.nix
  ];
  age.secrets.tokens-nix = {
    path = "/etc/nix/tokens.conf";
    mode = "0400";
    owner = "root";
  };

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
        "flakes"
        "nix-command"

        "fetch-tree"
        "fetch-closure"
        "pipe-operators"

        "blake3-hashes"
        "git-hashing"
        "no-url-literals"

        "auto-allocate-uids"
        "dynamic-derivations"
        "cgroups"
        "parse-toml-timestamps"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nadevko.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nadevko.cachix.org-1:fmf8N0u8U9RbHYvqw0hP+akk2/tQ8rdm1SWsCogX4tU="
      ];

      trusted-users = [ "@wheel" ];
      fallback = true;
      use-xdg-base-directories = true;
      auto-optimise-store = true;

      auto-allocate-uids = true;
      use-cgroups = true;
      accept-flake-config = true;
      builders-use-substitutes = true;
    };
    extraOptions = ''
      !include ${config.age.secrets.tokens-nix.path}
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "3h";
      options = "--delete-older-than 7d";
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) inputs;
  };
  nixpkgs = {
    flake.setNixPath = true;
    hostPlatform = "x86_64-linux";
  };
  programs.nix-ld.enable = true;
}
