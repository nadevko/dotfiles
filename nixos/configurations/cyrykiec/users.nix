{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.self.nixosModules.agenix ];
  age.secretsFile.root = inputs.self;

  users.users = {
    nadevko = {
      description = "Nadeŭka";
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.age.secrets.passwordNadevko.path;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8tNKlqyo0gojPF7jLuOhts8OZSQYmR7a5kpLo2jjRd nadevko@klinicyst"
      ];
    };
    root.hashedPasswordFile = config.age.secrets.passwordRoot.path;
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
      root.home = config.users.users.root.home;
    };
    systemPackages = [ pkgs.gitFull ];
  };

  age.identityPaths = [
    "/nix/persist/etc/ssh/ssh_host_ed25519_key"
    "/nix/persist/etc/ssh/ssh_host_rsa_key"
  ];
}
