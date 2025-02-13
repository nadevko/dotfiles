{
  config,
  pkgs,
  lib,
  ...
}:
{
  _class = "nixos";
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
    <nixpkgs/nixos/modules/profiles/all-hardware.nix>
  ];

  isoImage = {
    isoName = "${config.isoImage.isoBaseName}-${pkgs.stdenv.hostPlatform.system}.iso";
    makeEfiBootable = true;
    makeUsbBootable = true;
    edition = "custom";
  };
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
  };
  boot = {
    postBootCommands = ''
      for o in $(</proc/cmdline); do
        case "$o" in
          live.nixos.passwd=*)
            set -- $(IFS==; echo $o)
            echo "nixos:$2" | ${pkgs.shadow}/bin/chpasswd
            ;;
        esac
      done
    '';
    supportedFilesystems = [
      "btrfs"
      "cifs"
      "f2fs"
      "ntfs"
      "vfat"
      "xfs"
    ] ++ lib.optional (lib.meta.availableOn pkgs.stdenv.hostPlatform config.boot.zfs.package) "zfs";
    loader.grub.memtest86.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = lib.trivial.release;

  swapDevices = lib.mkImageMediaOverride [ ];
  fileSystems = lib.mkImageMediaOverride config.lib.isoFileSystems;

  networking.hostId = lib.mkDefault "8425e349";
}
