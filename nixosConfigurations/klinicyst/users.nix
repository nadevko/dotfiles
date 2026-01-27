{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.home.nixosModules.default ];

  security.pam.services.systemd-run0 = {
    setEnvironment = true;
    pamMount = false;
  };

  security = {
    polkit = {
      enable = true;
      extraConfig = ''
        // Allow users group to use login1 actions (for session management)
        polkit.addRule(function (action, subject) {
          if (subject.isInGroup("users") && action.id.startsWith("org.freedesktop.login1.")) {
            return polkit.Result.YES;
          }
        });

        // Allow wheel group to execute nixos-rebuild and related programs without password
        polkit.addRule(function (action, subject) {
          if (subject.isInGroup("wheel") && action.id == "org.freedesktop.policykit.exec") {
            var allowedPrograms = [
              "${config.system.build.nixos-rebuild}/bin/nixos-rebuild",
              "${config.nix.package}/bin/nix-collect-garbage",
              "${config.nix.package}/bin/nix"
            ];
            var program = action.lookup("program");

            if (program && allowedPrograms.indexOf(program) !== -1) {
              return polkit.Result.YES;
            }
          }
        });

        // Allow wheel group to manage systemd units
        polkit.addRule(function (action, subject) {
          var systemdActions = [
            "org.freedesktop.systemd1.manage-units",
            "org.freedesktop.systemd1.manage-unit-files",
            "org.freedesktop.systemd1.reload-daemon",
            "org.freedesktop.systemd1.set-environment"
          ];

          if (subject.isInGroup("wheel") && systemdActions.indexOf(action.id) !== -1) {
            return polkit.Result.YES;
          }
        });
      '';
    };
    sudo.enable = false;
  };
  users.users = {
    nadevko = {
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
    root.hashedPasswordFile = config.age.secrets.passwords-root.path;
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
    users.nadevko.imports = pkgs.lib.collectNixFiles ../../homeConfigurations/nadevko;
    backupFileExtension = "home.bak";
    extraSpecialArgs.inputs = inputs;
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  environment.etc = {
    "nixos/flake.nix".source =
      "${config.home-manager.users.nadevko.xdg.userDirs.desktop}/dotfiles/flake.nix";
  };
}
