{
  config,
  pkgs,
  lib,
  ...
}:
let
  maintainer = import ../.. { inherit pkgs; };
  secrix = service: secret: config.services.${service}.secrets.${secret}.decrypted.path;
in
{
  _class = "nixos";
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ] ++ lib.attrValues maintainer.modules;

  config = {
    secrix = {
      hostPubKey = builtins.readFile ./secrix.key.pub;
      hostIdentityFile = builtins.toString ./secrix.key;
      services.iwd.secrets = {
        wirelessNetworks.encrypted.file = ./.wirelessNetworks.nix.age;
        wirelessSecretsFile.encrypted.file = ./.wirelessSecretsFile.ini.age;
      };
    };
    networking.wireless = {
      enable = false;
      iwd.enable = true;
      networks = import (secrix "iwd" "wirelessNetworks");
      secretsFile = secrix "iwd" "wirelessSecretsFile";
    };
    nixpkgs.overlays = lib.attrValues maintainer.overlays;
    boot.initrd.availableKernelModules = lib.mkForce [ ];
    boot.supportedFilesystems = lib.mkForce [ ];
    hardware.enableRedistributableFirmware = lib.mkForce false;
    environment.systemPackages = lib.mkForce [ pkgs.parted ];
  };
}
