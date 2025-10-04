{ pkgs, modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  hardware.enableAllFirmware = true;
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    nixos-anywhere
    disko
  ];

  boot.initrd = {
    availableKernelModules = [
      "aes"
      "xts"
      "sha256"
      "btrfs"
      "dm-crypt"
      "cryptd"
      "crc32c-intel"
    ];

    luks.cryptoModules = [
      "aes"
      "xts"
      "sha256"
    ];
  };
}
