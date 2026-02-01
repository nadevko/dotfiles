{ config, pkgs, ... }:
{
  users.users = {
    nadevko = {
      description = "Nadeŭka";
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.age.secrets.passwords-nadevko.path;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5AMwC9jHZy8sEuUavwKdWwj3aU+930sd10mITaNyxM nadevko@klinicyst"
      ];
    };
    root.hashedPasswordFile = config.age.secrets.passwords-root.path;
  };
  users.mutableUsers = false;
  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  environment = {
    persistence."/nix/persist".users = {
      nadevko = {
        directories = [
          "Desktop"
          "Repos"
        ];
      };
    };
    systemPackages = with pkgs; [ gitFull ];
  };

  age.identityPaths = [
    "/nix/persist/etc/ssh/ssh_host_ed25519_key"
    "/nix/persist/etc/ssh/ssh_host_rsa_key"
  ];
}
