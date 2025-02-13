{
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  maintainer = import ../.. { inherit pkgs; };
in
{
  _class = "nixos";
  imports = [
    <nixpkgs/nixos/modules/profiles/installation-device.nix>
    ./isoImage.nix
  ] ++ attrValues maintainer.modules;

  config = {
    environment.systemPackages = with pkgs; [
      disko
      arch-install-scripts
      debootstrap
      kickstart
      dnf4

      util-linux
      ddrescue
      ccrypt
      cryptsetup

      ms-sys
      efibootmgr
      efivar

      testdisk
      sdparm
      hdparm
      smartmontools
      pciutils
      usbutils
      nvme-cli

      fuse
      fuse3
      sshfs-fuse
      socat
      tcpdump

      w3m-nographics
    ];
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    users.users.root.openssh.authorizedKeys.keys = [ (builtins.readFile ./ssh.key.pub) ];
    console.packages = options.console.packages.default ++ [ pkgs.terminus_font ];
    documentation.man.enable = mkImageMediaOverride true;
    networking.wireless.enable = true;
    fonts.fontconfig.enable = false;
    services.rsyncd.enable = true;
    programs.git.enable = true;
  };
}
