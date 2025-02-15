{ writeShellApplication }:
writeShellApplication {
  name = "nix-channel-setup";
  text = ''
    valid_channel='(nixos-(\d\d\.\d\d(-(small|testing|aarch64))?|test-staging(-baseline)?|unstable(-small)?)|nixpkgs-(\d\d\.\d\d-darwin|spectrum-os|tests?|unstable|upstream|vnc))'
    if [[ ! -f $1 && ! -f $1/default.nix ]]; then
      echo "$0: file '$1' does not exist."
      exit 1
    fi
    if [[ ! $2 =~ $valid_channel ]]; then
      echo -e \
        "$0: please pass a valid NixOS channel name. You can view them here: https://channels.nix.gsc.io/"
      exit 1
    fi
    entries="$(nix-instantiate --eval --expr "import ${./join.nix} (import $1 \"$2\")")"
    entries="''${entries#'"'}"
    entries="''${entries%';"'}"
    IFS=";"
    for i in $entries; do
      name="''${i##* }"
      echo "Adding '$name' channel..."
      nix-channel --add "''${i%% *}" "$name"
    done
  '';
}
