{ inputs, ... }:
{
  imports = [ inputs.self.nixosModules.hardware-by-laptop-Asus-X-550LB-XO023D ];

  system = {
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
    channel.enable = false;
  };
  nixpkgs = {
    system = "x86_64-linux";
    flake.setNixPath = true;
  };
}
