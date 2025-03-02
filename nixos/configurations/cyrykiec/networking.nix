{ config, pkgs, ... }:
{
  networking = {
    hostName = "cyrykiec";
    wireless = {
      enable = true;
      networks = {
        "BN1904A_2.4".pskRaw = "ext:psk_aa";
        "HUAWEI-A1-E99B00".pskRaw = "ext:psk_ab";
        "HUAWEI-A1-E99B00-2.4".pskRaw = "ext:psk_ab";
        "HUAWEI-A1-E99BOO".pskRaw = "ext:psk_ab";
        "HUAWEI-A1-E99BOO-2.4".pskRaw = "ext:psk_ab";
      };
      secretsFile = config.age.secrets.networkingWirelessSecretsFile.path;
    };
    interfaces = {
      enp2s0f1.useDHCP = true;
      wlp3s0f0.useDHCP = true;
    };
    # fail2ban.enable = true;
    firewall.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      package = pkgs.openssh_hpn;
      banner = ''

                                              dP       oo
                                              88
          .d8888b. dP    dP 88d888b. dP    dP 88  .dP  dP .d8888b. .d8888b.
          88'  `"" 88    88 88'  `88 88    88 88888"   88 88ooood8 88'  `""
          88.  ... 88.  .88 88       88.  .88 88  `8b. 88 88.  ... 88.  ...
          `88888P' `8888P88 dP       `8888P88 dP   `YP dP `88888P' `88888P'
                        .88               .88
                    d8888P            d8888P

        ------------------------------------------- SRV-NB00 P --------------
        -- Server -- NoteBook 0 -- Production -------------------------------

      '';
      settings = {
        UsePAM = false;
        UseDns = false;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      authorizedKeysInHomedir = false;
    };
    cloudflared = {
      enable = true;
      certificateFile = config.age.secrets.networkingCloudflaredCyrykiecCert.path;
      tunnels."3e4dc4f6-fd99-47f0-94dd-38fe18b0d49d" = {
        credentialsFile = "${config.age.secrets."networkingCloudflaredCyrykiec-3e4dc4f6-fd99-47f0-94dd-38fe18b0d49d".path
        }";
        default = "http_status:404";
      };
    };
  };
}
