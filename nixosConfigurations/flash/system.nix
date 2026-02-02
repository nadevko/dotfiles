{ pkgs, inputs, ... }:
{
  imports = [ (inputs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix") ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  hardware.enableAllFirmware = true;

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
