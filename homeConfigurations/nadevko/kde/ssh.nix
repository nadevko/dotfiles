{ pkgs, config, ... }:
{
  home.sessionVariables = {
    SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };
  home.packages = [ pkgs.kdePackages.ksshaskpass ];

  systemd.user.services.ssh-add-xdg-secrets-dir = {
    Service.Type = "oneshot";
    Unit = {
      Description = "Import SSH keys into agent after KDE Wallet";
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service.Environment = [
      "SSH_ASKPASS=${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass"
      "SSH_ASKPASS_REQUIRE=prefer"
      "SSH_DIR=${config.xdg.userDirs.extraConfig.SECRETS}/ssh"
    ];
    Service.ExecStart = pkgs.writeShellScript "ssh-add-xdg-secrets-dir" ''
      ${pkgs.dbus}/bin/dbus-wait --session --name org.kde.kwalletd6
      find "$SSH_DIR" -type f ! -name "*.pub" -exec ${pkgs.openssh}/bin/ssh-add -q {} ';'
    '';
  };
}
