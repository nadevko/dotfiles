{
  programs.ssh.knownHosts = {
    "git.launchpad.net".publicKey =
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEFREwBD2ye2Xrc2SVcUmmJ44MF1BCB3W11NTaiqzVj7XZnQmgWZk9UadHVY2wBXvelcDO51MPN5ozJjFAknw09rP7XMRJMlAOLSIVoU6DRF1u1j8kJVY+dfiDHheS7+siADnrmb8HGn2xQQ6EJDjAXrw1x58x5eZjQ0PFWdI+pRTdYGvWkpHdXKFO6a9/lDx4uo9MCnePEGi/QnkCmKqLCBUlYNZYRiB8nVee2tMF0mjV8xk1rJ+/UP+897+FXFR9w/B1EPRjiQ35ZNQZKPP4isxPtyMuCQkZY7ckWr5YsylNfvNcyGDnO1XazZhJ71rzDpi1RmnFXBW5i+2dm2y7";
    "codebasehq.com".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZoKai03b98KTKgySr5fLoWKpM0uuexaWZOOPNp85P/";
    "ssh.dev.azure.com" = {
      extraHostNames = [ "vs-ssh.visualstudio.com" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Hr1oTWqNqOlzGJOfGJ4NakVyIzf1rXYd4d7wo6jBlkLvCA4odBlL0mDUyZ0/QUfTTqeu+tm22gOsv+VrVTMk6vwRU75gY/y9ut5Mb3bR5BV58dKXyq9A9UeB5Cakehn5Zgm6x1mKoVyf+FFn26iYqXJRgzIZZcZ5V6hrE0Qg39kZm4az48o0AUbf6Sp4SLdvnuMa2sVNwHBboS7EJkm57XQPVU3/QpyNLHbWDdzwtrlS+ez30S3AdYhLKEOxAG8weOnyrtLJAUen9mTkol8oII1edf7mWWbWVf0nBmly21+nZcmCTISQBtdcyPaEno7fFQMDD26/s0lfKob4Kw8H";
    };
    "gitea.com".publicKey =
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHENMBc3mpZqI9+X6BM0ADeXLHDYV5s/FJMs4rXoyXgaSmBdk01UWyuUzpcs692oNM4kzFai0i2JZT/Cz0wKi5X+C/o7gF3u+wEwFax/5UYGbVjWmCW2yCwhzMoqV2C9i9k0tY/cLLe22GHjzxZYzsF9apJe2ANSBgH1Lq2A8lHuvN6N7MQwkGhxXmtRaupZUrz0yiJdcTEICfFE94SCLcbBu2bnqGEPE0m6OafgUF/7aJlz1/EFg7SE9UBExzGcYLFK6RPf3X0WZx691Sq0VR9N9LHBquMtZsrsXbicHh0RgCdgS0zJBZrF7KCIWuAYVNTluyA8S5RjPXwQc+zhgP";
    "git.savannah.nongnu.org" = {
      extraHostNames = [ "git.sv.nongnu.org" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnMLHxGS/b6Su98mL/J58FkpEJY/X1mONqhPBuFX5sJ";
    };
    "pagure.io".publicKey =
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC198DWs0SQ3DX0ptu+8Wq6wnZMrXUCufN+wdSCtlyhHUeQ3q5B4Hgto1n2FMj752vToCfNTn9mWO7l2rNTrKeBsELpubl2jECHu4LqxkRVihu5UEzejfjiWNDN2jdXbYFY27GW9zymD7Gq3u+T/Mkp4lIcQKRoJaLobBmcVxrLPEEJMKI4AJY31jgxMTnxi7KcR+U5udQrZ3dzCn2BqUdiN5dMgckr4yNPjhl3emJeVJ/uhAJrEsgjzqxAb60smMO5/1By+yF85Wih4TnFtF4LwYYuxgqiNv72Xy4D/MGxCqkO/nH5eRNfcJ+AJFE7727F7Tnbo4xmAjilvRria/+l";
    "git.code.sf.net".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGObtXLh/mZom0pXjE5Mu211O+JvtzolqdNKVA+XJ466";
    "gitgud.io".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJYzshLPVDRJki9gBdMYHEObQxvv1HvVh8ldRxLmFVC";
    "iris.radicle.xyz".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCHL/pbyjZ8Mm1esh6rXe5x/QSDzPUtiR0RZMhRqPoe";
    "framagit.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSgY54eVXNl+dIlpjkSiIXNaj+V734R9DAw3uUY2YFD";
    "notabug.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE3YpQ6KcSrUjAGHVg1ziYDWi9Iyal0V7B3fcNFlX930";
  };
}
