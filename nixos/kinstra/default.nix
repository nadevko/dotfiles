{
  pkgs,
  ...
}:
{
  _class = "nixos";

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    (import ../common)
  ];

  config = {
    environment.systemPackages = [
      pkgs.nur.repos.mic92.hello-nur
    ];
  };
}
