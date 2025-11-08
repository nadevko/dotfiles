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
}
