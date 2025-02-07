final: prev: with builtins; mapAttrs (k: v: import /${root}/${k} final prev) (readDir ../lib)
