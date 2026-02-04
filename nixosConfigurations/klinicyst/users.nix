{
  home-manager,
  kasumi,
  inputs,
  config,
  ...
}:
{
  imports = [ home-manager.nixosModules.default ];

  users.users.nadevko = {
    description = "Nadeŭka";
    extraGroups = [
      "adbusers"
      "docker"
      "networkmanager"
      "video"
      "wheel"
      "wireshark"
    ];
    hashedPasswordFile = config.age.secrets.passwords-nadevko.path;
    isNormalUser = true;
  };
  users.users.root = {
    hashedPasswordFile = config.age.secrets.passwords-root.path;
  };

  users.mutableUsers = false;

  services.postgresql = {
    ensureUsers = [
      {
        name = "nadevko";
        ensureDBOwnership = true;
        ensureClauses = {
          superuser = true;
          login = true;
        };
      }
    ];
    ensureDatabases = [ "nadevko" ];
  };

  home-manager = {
    users.nadevko.imports = kasumi.lib.collectNixFiles ../../homeConfigurations/nadevko;
    backupFileExtension = "home.bak";
    extraSpecialArgs = inputs // {
      inherit inputs;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
