{ config, ... }:
{
  security.pam.services.systemd-run0 = {
    setEnvironment = true;
    pamMount = false;
    rootOK = true;
    sshAgentAuth = true;
  };
  security.sudo.enable = false;

  security.polkit = {
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
}
