final: prev: {
  nadevko.modules = {
    nixos = import ../nixos/lib;
    home-manager = import ../home-manager/lib;
  };
  lib = prev.lib // {
    mkNanorcBundle = prev.callPackage ./mkNanorcBundle { };
  };
  nadevko.nanorc = prev.callPackage ./nanorc { };
}
