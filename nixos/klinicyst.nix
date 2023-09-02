{ lib, pkgs, ... }: {
  imports = [ ./lib ];
  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "sdhci_pci" ];
      kernelModules = [ "essiv" ];
      luks.devices.nixos.allowDiscards = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "amd_pstate=active" ];
  };
  fileSystems = {
    "/" = {
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" ];
    };
    "/home" = {
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" ];
    };
    "/boot" = {
      fsType = "vfat";
      options = [ "noatime" ];
    };
    "/var/swap" = {
      fsType = "btrfs";
      options = [ "subvol=@swap" "compress=zstd" ];
    };
  };
  networking = {
    hostName = "klinicyst";
    interfaces.wlp1s0.useDHCP = lib.mkDefault true;
    firewall.enable = true;
  };
  services = {
    xserver = {
      videoDrivers = [ "amdgpu" ];
      layout = "us";
    };
    fstrim.enable = true;
  };
  users = {
    mutableUsers = false;
    users = {
      nadevko = {
        description = "Nadeŭka";
        extraGroups = [ "wheel" "networkmanager" ];
        isNormalUser = true;
      };
    };
  };
  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
        libva
        vaapiVdpau
      ];
      driSupport32Bit = true;
      extraPackages32 = with pkgs.driversi686Linux; [ amdvlk vaapiVdpau ];
    };
  };
  system = {
    autoUpgrade = {
      enable = true;
      dates = "1mounth";
    };
    stateVersion = "23.11";
  };
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    unfree.enable = true;
  };
  i18n.defaultLocale = "be_BY.UTF-8";
  environment.variables.AMD_VULKAN_ICD = "RADV";
  security.sudo.wheelNeedsPassword = false;
  time.timeZone = "Europe/Minsk";
}
