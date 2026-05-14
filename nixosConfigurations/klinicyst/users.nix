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
