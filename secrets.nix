let
  publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG27bcRRDTtacbYscoiBG3Xyr/Jmd4txTXsWbjvrRA9d agenix"
  ];

  nixosConfigurationsKeys = {
    klinicyst = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA45rfSE6lkVDpJFxaRp6LduZfHAe9O0QAceupz1n87e root@klinicyst";
    cyrykiec = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICve27Avl7E0Uuna/cox2zfETm81ZalnhtYD++fGs00w root@cyrykiec";
  };
  nixosConfigurations = builtins.attrNames nixosConfigurationsKeys;

  mkSecrets = builtins.mapAttrs (
    _: extra:
    extra
    // {
      publicKeys = publicKeys ++ map (n: nixosConfigurationsKeys.${n}) extra.nixosConfigurations;
    }
  );
in
mkSecrets {
  "secrets/passwords/nadevko.age" = {
    name = "passwords-nadevko";
    inherit nixosConfigurations;
  };
  "secrets/passwords/root.age" = {
    name = "passwords-root";
    inherit nixosConfigurations;
  };
  "secrets/wireless/networks.age" = {
    name = "wireless-networks";
    nixosConfigurations = [ "cyrykiec" ];
  };
  "secrets/cloudflared/cyrykiec.age" = {
    name = "cloudflared-cyrykiec";
    nixosConfigurations = [ "cyrykiec" ];
  };
  "secrets/cloudflared/ec4101e2-f34b-409e-b109-f31cb3480d71.age" = {
    name = "cloudflared-ec4101e2-f34b-409e-b109-f31cb3480d71";
    nixosConfigurations = [ "cyrykiec" ];
  };
  "secrets/xray/klinicyst.age" = {
    name = "xray-klinicyst";
    nixosConfigurations = [ "klinicyst" ];
  };
}
