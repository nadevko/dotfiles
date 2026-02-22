{
  programs.ssh.knownHosts = {
    "github.com" = {
      extraHostNames = [ "gist.github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
    "gitlab.com".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
    "bitbucket.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazEu89wgQZ4bqs3d63QSMzYVa0MuJ2e2gKTKqu+UUO";
    "codeberg.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVIC02vnjFyL+I4RHfvIGNtOgJMe769VTF1VR4EB3ZB";
    "git.sr.ht".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";

    "gitee.com".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKxHSJ7084RmkJ4YdEi5tngynE8aZe2uEoVVsB/OvYN";
    "iris.radicle.xyz".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCHL/pbyjZ8Mm1esh6rXe5x/QSDzPUtiR0RZMhRqPoe";
    "gitflic.ru".publicKey =
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCYadzx/Pyje3UxJamIEpYlHP5PGfhg9Sb1zfR1QOnBPlzvi7tttV2uGNqnjrMLka72SBKTSUo8bGNQMnLX+3lFsKXvBMsl8OXXg02209U/tU/0EbwgjrwY5Sqitq+2xRX7jpJ53Dw9Iap6qBS+ZqPVnVwth/+KUSiGHY3jlaZxEidEV5zO2Ix4SYHnRYHyncJA1DCVPQ9Q4V6EAZqgSKPQ/uhEU76KwTkqg0pfJO33h08iKKvzxkddqXN7ek2YQ1ljC04BDTg3ouNr2tbMhdnCS0RSSpIdR81JdDndbQIhfOEsck8njTDKLhHSoiKG19ijZUn3BxMKDoU8bi/8P1Yy8Po43uBLancmCSdUz8BL/ee+f+Q3KRv2+jySCA1FEfetBgJRv+wqwE8634GDuysXIQMlIcZsg3BQkE60JAkV7ejKV1JuxeBRhKbSl1CXMDtn1z0FG7I9q4odknTb4PacejjpyEiajDuMBm3L0uH8IRW/QGcZdY3aISROlCvPjdtzKd2tlPuBZBjxUng0j2TqVz/unUXpbIcmu9WYG/7atFQzWloQDUh1LmTbXSuPKtaVArNiFdcBLUi4pbGyK7DLQwGweKJqUtVRKl8e/ai9vluwd86ACWbB9l1eahVEt3uTozThQlc64CAwPdK8vlz1an2i5ekskTFvG9mh2d2yQw==";
    "git.launchpad.net".publicKey =
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEFREwBD2ye2Xrc2SVcUmmJ44MF1BCB3W11NTaiqzVj7XZnQmgWZk9UadHVY2wBXvelcDO51MPN5ozJjFAknw09rP7XMRJMlAOLSIVoU6DRF1u1j8kJVY+dfiDHheS7+siADnrmb8HGn2xQQ6EJDjAXrw1x58x5eZjQ0PFWdI+pRTdYGvWkpHdXKFO6a9/lDx4uo9MCnePEGi/QnkCmKqLCBUlYNZYRiB8nVee2tMF0mjV8xk1rJ+/UP+897+FXFR9w/B1EPRjiQ35ZNQZKPP4isxPtyMuCQkZY7ckWr5YsylNfvNcyGDnO1XazZhJ71rzDpi1RmnFXBW5i+2dm2y7";

    "forge-allura.apache.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKPEyv5W9IrkptnDngML1R4kbWKqKbjdgiEbBdG38u95";
    "invent.kde.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMtd90DMLrtdCiapQK43JjwKk+U8egSXQU15fOJba1n";
    "ssh.gitlab.gnome.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHG6b3deoYMPwKEu9Sj+y6MBHYYUKQiAnta/go3aNv7R";
    "ssh.dev.azure.com" = {
      extraHostNames = [ "vs-ssh.visualstudio.com" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Hr1oTWqNqOlzGJOfGJ4NakVyIzf1rXYd4d7wo6jBlkLvCA4odBlL0mDUyZ0/QUfTTqeu+tm22gOsv+VrVTMk6vwRU75gY/y9ut5Mb3bR5BV58dKXyq9A9UeB5Cakehn5Zgm6x1mKoVyf+FFn26iYqXJRgzIZZcZ5V6hrE0Qg39kZm4az48o0AUbf6Sp4SLdvnuMa2sVNwHBboS7EJkm57XQPVU3/QpyNLHbWDdzwtrlS+ez30S3AdYhLKEOxAG8weOnyrtLJAUen9mTkol8oII1edf7mWWbWVf0nBmly21+nZcmCTISQBtdcyPaEno7fFQMDD26/s0lfKob4Kw8H";
    };
  };
}
