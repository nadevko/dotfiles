{ config, pkgs, ... }:
{
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "sdhci_pci"
    ];
    kernelModules = [
      "acpi_call"
      "kvm-amd"
    ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  hardware = {
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
    cpu.amd.updateMicrocode = true;
    graphics.enable32Bit = true;
    enableRedistributableFirmware = true;
  };
  services = {
    xserver.videoDrivers = [ "modesetting" ];
    fstrim.enable = true;
  };

  console = {
    font = pkgs.terminus_font + "/share/consolefonts/ter-v32n.psf.gz";
    earlySetup = true;
  };
}
