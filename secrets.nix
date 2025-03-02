let
  nixosConfigurations' = {
    klinicyst = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA45rfSE6lkVDpJFxaRp6LduZfHAe9O0QAceupz1n87e root@klinicyst";
    cyrykiec = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICve27Avl7E0Uuna/cox2zfETm81ZalnhtYD++fGs00w root@cyrykiec";
  };

  publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILuR464bxRal1A6bZNkt9hEf8c9xNtY1Y8mTPSGKUlqy"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG27bcRRDTtacbYscoiBG3Xyr/Jmd4txTXsWbjvrRA9d agenix"
  ];
  nixosConfigurations = builtins.attrNames nixosConfigurations';

  mkSecrets = builtins.mapAttrs (
    hostName: details:
    details
    // {
      publicKeys = publicKeys ++ map (n: nixosConfigurations'.${n}) details.nixosConfigurations;
    }
  );
in
mkSecrets {
  "secrets/password/nadevko.age" = {
    name = "passwordNadevko";
    inherit nixosConfigurations;
  };
  "secrets/password/root.age" = {
    name = "passwordRoot";
    inherit nixosConfigurations;
  };
  "secrets/networking/wireless/secrets-file.age" = {
    name = "networkingWirelessSecretsFile";
    nixosConfigurations = [ "cyrykiec" ];
  };
  "secrets/networking/cloudflared/cyrykiec/cert.age" = {
    name = "networkingCloudflaredCyrykiecCert";
    nixosConfigurations = [ "cyrykiec" ];
  };
  "secrets/networking/cloudflared/cyrykiec/3e4dc4f6-fd99-47f0-94dd-38fe18b0d49d.age" = {
    name = "networkingCloudflaredCyrykiec-3e4dc4f6-fd99-47f0-94dd-38fe18b0d49d";
    nixosConfigurations = [ "cyrykiec" ];
  };
}
