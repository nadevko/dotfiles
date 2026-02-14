{
  programs.direnv = {
    enable = true;
    config.global = {
      disable_stdin = true;
      load_dotenv = true;
    };
    nix-direnv.enable = true;
    stdlib = ''
      base64-to-base64url() {
        local base64url="''${1//+/-}"
        base64url="''${base64url//\//_}"
        echo "''${base64url//=/}"
      }

      declare -A direnv_layout_dirs
      direnv_layout_dir() {
        echo "''${direnv_layout_dirs[$PWD]:=$(
          local hash=$(nix hash path --algo blake3 --format base64 --mode flat <(printf %s "$PWD"))
          hash=$(base64-to-base64url "$hash")
          echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash:0:32}-''${PWD##*/}"
        )}"
      }
    '';
  };
}
