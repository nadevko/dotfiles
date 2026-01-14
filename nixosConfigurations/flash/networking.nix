{
  networking = {
    hostName = "flash";
    networkmanager.enable = true;
  };

  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExmj0EELBzDcxLKczuSjYwDlct6BdxaRk8DMfny7t5p nixos"
  ];

  services.openssh = {
    enable = true;
    banner = ''
         __ _           _
        / _| |         | |
       | |_| | __ _ ___| |__
       |  _| |/ _` / __| '_ \
       | | | | (_| \__ \ | | |
       |_| |_|\__,_|___/_| |_|
      ----------- ISO-FD01 P --
    '';
  };
}
