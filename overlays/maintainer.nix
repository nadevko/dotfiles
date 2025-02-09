final: prev:
with (import ../nonbuiltins.nix);
filterAttrs (k: v: k != "modules" && k != "overlays") (import ../. { pkgs = prev; })
// {
  lib = recursiveUpdate prev.lib (fix (libOverlay ../lib) prev);
}
