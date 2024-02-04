{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    package = (pkgs.vim-full.override {
      features = "tiny";
      wrapPythonDrv = false;
      guiSupport = false;
      luaSupport = false;
      perlSupport = false;
      pythonSupport = false;
      rubySupport = false;
      nlsSupport = false;
      tclSupport = false;
      multibyteSupport = false;
      cscopeSupport = false;
      netbeansSupport = false;
      ximSupport = false;
      darwinSupport = false;
      ftNixSupport = false;
      sodiumSupport = false;
    });
  };
}
