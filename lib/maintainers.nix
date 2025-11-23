final: prev:
let
  self = {
    nadevko = {
      name = "Nadeŭka";
      email = "me@nadevko.cc";
      github = "nadevko";
      githubId = 93840073;
    };
  };
in
self // { _excludeShortcuts = builtins.attrNames self; }
