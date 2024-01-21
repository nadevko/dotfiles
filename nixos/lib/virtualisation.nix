{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    # wineWowPackages.waylandFull
    winetricks
  ];
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
  };
}
