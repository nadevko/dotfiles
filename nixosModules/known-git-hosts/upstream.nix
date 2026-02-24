{
  programs.ssh.knownHosts = {
    "forge-allura.apache.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKPEyv5W9IrkptnDngML1R4kbWKqKbjdgiEbBdG38u95";
    "invent.kde.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMtd90DMLrtdCiapQK43JjwKk+U8egSXQU15fOJba1n";
    "ssh.gitlab.gnome.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHG6b3deoYMPwKEu9Sj+y6MBHYYUKQiAnta/go3aNv7R";
    "salsa.debian.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKXSHb3wNeJC/stGkU/0vCAGpw4A0Zm2bfClmK+zkZWr";
    "gitlab.freedesktop.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzdNH/aTnOOINO/iGupQ/rYnmKF40ESCrkRg+5JkLVN";
    "git.drupal.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKCkFTXM7BUQUHlDkVmQV6qNkIeSIRBTNzlLn+T/APHa";
    "git.suckless.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIYQzRqLkXCa1REkjDSO+Hr88N6M1qg6miCNI4Hrxvv";
    "opendev.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvV7fFTjYP+vAuCF+4J6ghZpFCap4/1NjrShk9X6kYe";
    "git.savannah.gnu.org" = {
      extraHostNames = [ "git.sv.gnu.org" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnMLHxGS/b6Su98mL/J58FkpEJY/X1mONqhPBuFX5sJ";
    };
    "src.opensuse.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKNThLRPznU5Io1KrAYHmYpaoLQEMGM9nwpKyYQCkPx";
    "git.fsfe.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM3mrSEeYfFaq06BXszDSxa/hAazT2g1P8gNoyc0Hr3B";
    "gitea.com" = {
      extraHostNames = [ "try.gitea.com" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHENMBc3mpZqI9+X6BM0ADeXLHDYV5s/FJMs4rXoyXgaSmBdk01UWyuUzpcs692oNM4kzFai0i2JZT/Cz0wKi5X+C/o7gF3u+wEwFax/5UYGbVjWmCW2yCwhzMoqV2C9i9k0tY/cLLe22GHjzxZYzsF9apJe2ANSBgH1Lq2A8lHuvN6N7MQwkGhxXmtRaupZUrz0yiJdcTEICfFE94SCLcbBu2bnqGEPE0m6OafgUF/7aJlz1/EFg7SE9UBExzGcYLFK6RPf3X0WZx691Sq0VR9N9LHBquMtZsrsXbicHh0RgCdgS0zJBZrF7KCIWuAYVNTluyA8S5RjPXwQc+zhgP";
    };
  };
}
