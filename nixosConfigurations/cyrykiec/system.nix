{
  imports = [
    ../../nixosModules/hardware/by-laptop/Asus/X/550LB/XO023D.nix
    ../../nixosModules/agenix.nix
  ];

  system = {
    autoUpgrade = {
      enable = true;
      dates = "monthly";
      operation = "switch";
      allowReboot = true;
      persistent = true;
      rebootWindow = {
        lower = "04:00";
        upper = "07:00";
      };
    };
    stateVersion = "25.05";
    disableInstallerTools = true;
  };
  time.timeZone = "Europe/Minsk";
  documentation.enable = false;

  nix = {
    settings = {
      experimental-features = [
        "cgroups"
        "fetch-tree"
        "flakes"
        "nix-command"
      ];
      trusted-users = [ "@wheel" ];
      fallback = true;
      use-xdg-base-directories = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "3h";
    };
    optimise = {
      automatic = true;
      dates = [ "monthly" ];
      randomizedDelaySec = "3h";
    };
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "idle";
    channel.enable = false;
  };
}
