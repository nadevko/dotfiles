{ inputs, config, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "usb_storage"
      "sr_mod"
      "rtsx_pci_sdmmc"
    ];
    initrd.kernelModules = [
      "sd_mod"
      "ahci"
      "aesni_intel"
      "xts"
      "sha256"
      "dm_crypt"
      "cryptd"
      "crc32c-intel"
    ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "acpi_backlight=vendor"
      "i915.modeset=1"
      "intel_pstate=enable"
      "mem_sleep=deep"
    ];
    blacklistedKernelModules = [ "nouveau" ];
    loader.systemd-boot.consoleMode = "max";
  };

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_390;

      prime = {
        offload.enable = false;
        nvidiaBusId = "PCI:4:0:0";
        intelBusId = "PCI:0:2:0";
      };
      videoAcceleration = true;
      open = false;
    };
    intelgpu = {
      vaapiDriver = "intel-vaapi-driver";
      enableHybridCodec = true;
    };
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  services = {
    hdapsd.enable = true;
    tlp.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
    hostPlatform = "x86_64-linux";
  };
}
