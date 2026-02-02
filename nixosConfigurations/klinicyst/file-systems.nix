{
  boot = {
    initrd = {
      luks.devices.nixos = {
        device = "/dev/disk/by-uuid/bc8fe1b6-3e67-496e-8306-c0ea75b273f5";
        allowDiscards = true;
      };
      kernelModules = [ "essiv" ];
      systemd.enable = true;
      verbose = false;
    };
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 1;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
    ];
    plymouth.enable = true;
    consoleLogLevel = 0;
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/1B62-5DC0";
      fsType = "vfat";
      options = [
        "noatime"
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/34fa3158-ee1e-4b27-af93-326c5fe18ede";
      fsType = "btrfs";
      options = [
        "noatime"
        "discard=async"
        "subvol=@"
        "compress=zstd"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/34fa3158-ee1e-4b27-af93-326c5fe18ede";
      fsType = "btrfs";
      options = [
        "noatime"
        "discard=async"
        "subvol=@home"
        "compress=zstd"
      ];
    };
    "/var/swap" = {
      device = "/dev/disk/by-uuid/34fa3158-ee1e-4b27-af93-326c5fe18ede";
      fsType = "btrfs";
      options = [
        "noatime"
        "discard=async"
        "subvol=@swap"
        "compress=zstd"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/34fa3158-ee1e-4b27-af93-326c5fe18ede";
      fsType = "btrfs";
      options = [
        "noatime"
        "discard=async"
        "subvol=@nix"
        "compress=zstd"
      ];
    };
  };
  swapDevices = [ { device = "/var/swap/file"; } ];
}
