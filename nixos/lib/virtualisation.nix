{
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
    };
    docker = {
      enable = true;
      enableOnBoot = false;
      storageDriver = "btrfs";
    };
    waydroid.enable = true;
  };
}
