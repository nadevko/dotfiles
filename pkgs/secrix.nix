{
  stdenvNoCC,
  age,
  hostName ? "nixos",
  cfg ? {
    system.secrets = { };
    services = { };
    defaultEncryptKeys = { };
    hostPubKey = "";
    ageBin = "${age}/bin/age";
  },
}:
stdenvNoCC.mkDerivation rec {
  name = "secrix";

  src =
    let
      inherit (import <flake-compat> { src = <secrix>; }) defaultNix;
      inherit (defaultNix) secrix;
      nixosConfigurations.${hostName}.config.secrix = cfg;
      arg = { inherit nixosConfigurations; };
      inherit (secrix arg) program;
    in
    program;

  dontUnpack = true;
  dontBuild = true;

  patchPhase = ''
    substitute $src ${name} \
      --replace "nix run .#" ""
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 -t $out/bin ${name}
  '';
}
