{ impermanence, lib, ... }:
{
  imports = [ impermanence.nixosModules.default ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 16;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      postResumeCommands = lib.mkAfter ''
        mkdir /mnt
        mount /dev/mapper/nixos /mnt

        btrfs subvolume list -o /mnt/@ |
          cut -f 9 -d ' ' |
          while read subvol; do
            echo "deleting /$subvol subvolume..."
            btrfs subvolume delete "/mnt/$subvol"
          done &&
          echo "deleting root subvolume..." &&
          btrfs subvolume delete /mnt/@

        btrfs subvolume create /mnt/@
        umount /mnt
      '';
      luks.devices.nixos.device = "/dev/disk/by-uuid/56fcda4f-9b77-44d9-a42f-dc677b1259b7";
    };
    kernelParams = [
      "zswap.enabled=1"
      "zswap.max_pool_percent=25"
      "zswap.compressor=zstd"
      "resume=UUID=a3aa3cfb-6fe3-4ef5-b704-0782221530e7"
      "resume_offset=533760"
    ];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/9FF5-1470";
      fsType = "vfat";
      options = [
        "noatime"
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/a3aa3cfb-6fe3-4ef5-b704-0782221530e7";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd:7"
        "noatime"
        "nodiratime"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/a3aa3cfb-6fe3-4ef5-b704-0782221530e7";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd:7"
        "noatime"
        "nodiratime"
      ];
      neededForBoot = true;
    };
    "/nix/persist" = {
      device = "/dev/disk/by-uuid/a3aa3cfb-6fe3-4ef5-b704-0782221530e7";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress=zstd:7"
        "noatime"
        "nodiratime"
      ];
      neededForBoot = true;
    };
    "/var/swap" = {
      device = "/dev/disk/by-uuid/a3aa3cfb-6fe3-4ef5-b704-0782221530e7";
      fsType = "btrfs";
      options = [
        "subvol=@swap"
        "compress=zstd:7"
        "noatime"
        "nodiratime"
      ];
    };
  };
  swapDevices = [ { device = "/var/swap/file"; } ];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
