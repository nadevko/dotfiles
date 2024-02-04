{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    package = (pkgs.vim-full.override {
      features = "normal";
      wrapPythonDrv = false;
      guiSupport = false;
      luaSupport = false;
      perlSupport = false;
      pythonSupport = false;
      rubySupport = false;
      nlsSupport = true;
      tclSupport = false;
      multibyteSupport = true;
      cscopeSupport = false;
      netbeansSupport = false;
      ximSupport = true;
      darwinSupport = false;
      ftNixSupport = false;
      sodiumSupport = false;
    });
  };
}
