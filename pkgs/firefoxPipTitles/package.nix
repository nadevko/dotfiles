{
  lib,
  stdenvNoCC,
  fetchurl,

  unzip,
  jq,

  locales ? [ ],

  writeShellApplication,
}:
let
  inherit (builtins) attrNames concatStringsSep;
  inherit (lib.attrsets) getAttrs mapAttrsToList;
  inherit (lib) licenses platforms;
  inherit (lib.strings) escapeShellArgs;

  firefoxVersion = "142.0";
  firefoxLocales = if locales == [ ] then attrNames allFirefoxLanguagePacks else locales;

  allFirefoxLanguagePacks = {
    "ach" = "sha256-Zo+N+WGZ5rnAtZMwlTc1BOUHH63biR89bkV05+kNNcs=";
    "af" = "sha256-XvyJrvUPO9yIPPhCUR7OZczF6B2rBI/4dIqqsZ+dyO4=";
    "an" = "sha256-U2GXTrsKa7wzZT5JEMCREIbmtuTxhzIfa/YHhwhF7is=";
    "ar" = "sha256-5uHHLAq9f2w58AEu1+JM/wrAveegXb+WAkFReaSaCZo=";
    "ast" = "sha256-qHnOJw+46CQxGrxBpHIkW9tglC7cJbHhuy7G95OiP28=";
    "az" = "sha256-lHIC+dDrbBulTXHAFAbIJByemk/N51caOT6gEIW4Sy4=";
    "be" = "sha256-C6YxCVpquyAX9NTp/y+SLKeJgELombSzXvB3tm+MXd8=";
    "bg" = "sha256-ss78rzo+RXeXibbrmVfaYmpKyH76DByxi88aFFOkoOo=";
    "bn" = "sha256-teB11V0f2BQPDPFJ9y3Ua5avWazKT0UZT/TRJJDfhTI=";
    "br" = "sha256-S7WZeu2mZOtp+fI+2akSZTWeeOxr7t5U8V26fW5Z8JM=";
    "bs" = "sha256-o2g5taAMoiiGBC73876vBZ1oHOcBCZtUAXVJlDGqZm0=";
    "ca-valencia" = "sha256-whM4/5mBaKsg9Y+LfOp1UFTb7dZbazhZb1Xg7B8A0cU=";
    "ca" = "sha256-Xo18Nu6sFgG3S8df7s3b3PCXqShCJNHitk4Ii9/ihzg=";
    "cak" = "sha256-8fuVPxcXwwmRRUEthnh8aKDBT/0ol/BAoCR9dmJLjAc=";
    "cs" = "sha256-/k7gSLVghiwFY1hYfFxXXq6aL75owJ8r+FvOLgqyxic=";
    "cy" = "sha256-F2uj0z60NSPp9k/IUZBw+HCMcFcE9EAqho1A13bjZKA=";
    "da" = "sha256-lfrsdT4ju9yhM4saYqPrT3ZcdTLKu9XhY1FF6jl1JCc=";
    "de" = "sha256-VpwBEkgtbiL3u9cAkSec81IpXrmQiF+qLibqQcvjxGw=";
    "dsb" = "sha256-i6WvAzmPmZgiJ8bz50WtVZDS2agdwdMKPr1MLuf4mEw=";
    "el" = "sha256-575XX+lpaagudsMkUmzNKe1/go3FYIUmV1Ck+o98aZM=";
    "en-CA" = "sha256-2iReOhzPrb6cQBAToEIVaRVEbOVXff5iOKSFQjqjC0Q=";
    "en-GB" = "sha256-MKE4aCXh3lCDXnQvv8lnZaKTOwdWg+i3r7i7LaQakMg=";
    "en-US" = "sha256-hAhWvFYCQHklUK1VeypqcJyLrOtlGNrmkYosbTdV9I4=";
    "eo" = "sha256-vAsPiOY4a/gCIhlXAAd4CB0ZKk4JTKvqr8hM6n5sLPU=";
    "es-AR" = "sha256-JQEfijxzMKZus8qKrwvodyjVV8LSEnFw32fQCDP/1Jk=";
    "es-CL" = "sha256-PdeWzNTSw7XW2WkLE9OTcK7W2M5arw6LcZx2XyJbNtQ=";
    "es-ES" = "sha256-py89abSPDB/GGQaWMKSaL1RZcReuFADhvBlcecr5tKc=";
    "es-MX" = "sha256-VesDFU0sRGkA6Nbxpacq1cCv93jcthxzygPIRhhjjG0=";
    "et" = "sha256-p8F1EFcVY9Z2qfVjkKaiGBsgN4rsOD1dBATS8T7013o=";
    "eu" = "sha256-RJq+9VmBUdy0Hao2O56VItC/u9X0vOEOHr2NMrktzI4=";
    "fa" = "sha256-NJawCiY9CUacn87xiUwHTd8baU4laJB3lBQ+sS8LRy0=";
    "ff" = "sha256-YugjxSRB+kIkYQqaYrmWzip4S7Qq8+9b4ifIuOtCb5I=";
    "fi" = "sha256-faoe4JxO+XirC+hEKiAXuISk7525WYnMg2oadmAGai4=";
    "fr" = "sha256-eawNMwTaiODVSDpjwhWbdP1/Gvwahk7exhOAMdibgUw=";
    "fur" = "sha256-wanbaw43FrxFUBw8PVXexzXVdINQ/Y4zvfYlLDsXBM0=";
    "fy-NL" = "sha256-DIEFfFNzxHKae6n+zgx3cZqlQJxBYHqPVE+8tAWIQZI=";
    "ga-IE" = "sha256-MR5N/jrt4g0RQL9Wv2SrI9RoQ5FxD1Oo9zk/Q/nEfxw=";
    "gd" = "sha256-OPNAeg2sULpDV47Nq/j9Gtn5soeKg6hOkk6Gh1sI/Qs=";
    "gl" = "sha256-LJSu/njGDquZRn9gFy9insKO8rYtj+ssYRyI72jbN1g=";
    "gn" = "sha256-AGAS5iZc5zfzpioEmlIwuYpVRd6m0cRqjKUn8h1Z0XA=";
    "gu-IN" = "sha256-ikE/ieTY/NczVSdIq2VNo7f6ShOV2mEhWfG1SkDWqGs=";
    "he" = "sha256-b5S5x2DvGE1rEzfh8iFADETIWiUNDIm2yMZczclvWts=";
    "hi-IN" = "sha256-3hyMXG3kpSA/UeUFO14q6PEoJ2f7jRYPLtIXHn6no7g=";
    "hr" = "sha256-8v2SKLWHCV8d4aycaFjoXPr5ZigAgdZMHPn/0kdYIQU=";
    "hsb" = "sha256-yY6+yZOi9LwVouhzrJ2Y3gnVZPOpwzv8Cr29B8k4iuM=";
    "hu" = "sha256-XepvF+5fk2lfxxRA+lNotjGUiSj8yraNjvIHsZbPL8U=";
    "hy-AM" = "sha256-YVF8jU3Zys3FLsZZAFoOV3nNdEMv5iiOFJbeEt4w0PU=";
    "ia" = "sha256-/qCx8vVD63Zt+fyfqsgXgMqQe6qmB0pJsq7FEtsaIGs=";
    "id" = "sha256-KoT+Np0nCJuD3zHc7TrA2ttf9BExilqddAc1gnxiUp8=";
    "is" = "sha256-SFoimthBZ88hNGL6Kava6uTb694jLY0MS4304lRjHmo=";
    "it" = "sha256-h4+YXor7jzRfWae/SEiIv5fZjywPmWtLAufGrt5bLP4=";
    "ja" = "sha256-DQtk9B2Kv1Eu1Er7dLi0lt2np3WmkITW6+VBK/k5Wzs=";
    "ka" = "sha256-h+u8lrBKGt+JGQuNf+spec0VzIrSopZAzN41NBubLqg=";
    "kab" = "sha256-jzXD14ygQTpEEzhwzJg30rlC28Kjs6P15ZyanbeVKmE=";
    "kk" = "sha256-4VoHANszjzyMFa9HlEX+c/DAG4BKXERJjenyL9breVY=";
    "km" = "sha256-jj5j9HDT33Mu76hLjBp8SueCu2CshDAtugt06Uv3/c8=";
    "kn" = "sha256-98q3GjigkXKn/DSXNB59l3uHXXbF+7sPVgXfKe0CH+Y=";
    "ko" = "sha256-C+csYHlM4Ub3R6hlc0RbEEgPoYZGbLWozo8vvV81hZU=";
    "lij" = "sha256-RgymoKaAPHh9grTxMJ1MlqUgbK+Cu1OIDVUdkg7zxaE=";
    "lt" = "sha256-zbKfETdzZ4BbHBOVNunnstxOLRNpCttUjAG3C0mlWww=";
    "lv" = "sha256-O1LWbNrEMN4o1p39rXLBOBEg1UC5j+QK/CyQvrA8TbM=";
    "mk" = "sha256-3HPZfOJX0x3gvRmiC2ZWJf+rN90SQAKxoB3PgV837ds=";
    "mr" = "sha256-bdwh+z+B8K7h2wpRA5h+E8ifk+jEgtoVlRg24Kw2e20=";
    "ms" = "sha256-boLkQXNyVvp3aG2LoOIYQqAcViIPpHB5rblxm1JKHUU=";
    "my" = "sha256-u1XPOrXkeoj/AThuTDD7mJXq1jEmt3DegiGzGKGCllU=";
    "nb-NO" = "sha256-BEJVTG2aa4mFdRJRxSkmvozGw9drtASNYszrvv9y17w=";
    "ne-NP" = "sha256-JuH5R8CWEpxWk2SKcBO6oKmOEdUeIQMwvAActppH1BM=";
    "nl" = "sha256-bw+pQc4l/mxgOjhzseid4Tz/WDyi+Lpv9FBUP3gidzI=";
    "nn-NO" = "sha256-oFtvu3iihYge8RQ8i7iX2SnBqXUet8w9X+2GLcxxc00=";
    "oc" = "sha256-bDG9IXaa65/t4at3VI5Pe/CCLrJ3biXL2fp11nmWrX4=";
    "pa-IN" = "sha256-Ut6w54C47YwcfGhL8bGLPeZQLoaFdNzPprXjX8ps1qc=";
    "pl" = "sha256-I6UMSBEhuIP+36ZN09sEQPtSBT+QZpcq4gCXmYbBypc=";
    "pt-BR" = "sha256-PPTuxvMRfszBJ4mKIq+y/SNevIhB+MkWRa/M8MDf0cg=";
    "pt-PT" = "sha256-GDwRM+0d37qazQGuLffP7M6jYtrDUxSXmn3o8sSukXM=";
    "rm" = "sha256-PbAv05vuvs3tgYWwh6nxICxd6oOGwLjbnO6fYpf7M1o=";
    "ro" = "sha256-9RHQM+eCHs6IePDxOzFaHP+O9QGuP0F6hRhnqwm4oB8=";
    "ru" = "sha256-SnxIyKtXlIfJ5BIGmljeKs6qTl+yH3VHJa3cTo0DX3Y=";
    "sat" = "sha256-BAchxCsHqs0cql6APbcpU4JDA30BKdbpD53Z1xZagTo=";
    "sc" = "sha256-Oy964CyScamhnl/o898uzJCQ6WNNfKuIJoLTvgmxDz0=";
    "sco" = "sha256-9qkXKl4PIDk4vo77HHKCgde49quZ8L2qv+479rmY7s4=";
    "si" = "sha256-dhf3/VL3+8aMxRXS1SJFQskQwFqcd7L1tDHSEaI7TMA=";
    "sk" = "sha256-4MXgbgtqpTwextliG6VbDdCf79YrcjL3wpXpr5XGIc0=";
    "skr" = "sha256-bSQYkSs3Yy500oLzS0e0wtAD1ib0mm7QMw59ltnqSiI=";
    "sl" = "sha256-Nhlr/3UzbJ6uDT9pIj9a11WppmOOfevWpRmK7iFAoS0=";
    "son" = "sha256-8jsWnvfq2p5J1qkSDDjD1G5rIkk66vYZnwhzIUu7mL8=";
    "sq" = "sha256-cRwAguvmWlcpDFLsCcoHXVlfhPRq7XxhpRJOf+Rz21k=";
    "sr" = "sha256-OI4/bpFs68vnm2Qzjhsfp4iuZ5MJpxyjEHit0rd4M3M=";
    "sv-SE" = "sha256-88uS1dZxpHFUdmKUoRflhd577+g0ArK8g4akL/SjyTk=";
    "szl" = "sha256-eJqXeBQSWw9o5eBTJxxltD0dNaqnUVuLS7ooEngnF0s=";
    "ta" = "sha256-R19j56y75BHDkB9aQy12Me6M1lklpJo8HPEZ0qNWcQQ=";
    "te" = "sha256-KUBrAwgL0xwjhgkzA2+Xtl9HzCX0waAa66lO1HXC/NY=";
    "tg" = "sha256-VWms1pkH+iP7lz0FPaT8jNaVHmy0BNflZSqbnPrdUjQ=";
    "th" = "sha256-TpFBCqOwNubB/RIOLjnPUiziImOMEjXrRj6y3KKn3kU=";
    "tl" = "sha256-RBwQ3PcKaHsWlwI/9lU355tt4C/fMZvHgpclS67Bo5g=";
    "tr" = "sha256-mMrfj2nQ7AYEbLYnAmbObYv1DidXg2TzMIVot6CP+uo=";
    "trs" = "sha256-2kdpiFIedx5chIekeuzgZXDsvDEhS1eXQo4uU6BXobY=";
    "uk" = "sha256-N2gES6z2fTdbDZVjPgPT1GswwaaDNvuuaVSdykdQIJU=";
    "ur" = "sha256-wsMq1avBC8VZX39YVEk4JwZfOtZj+3yETXiyXpI3UnU=";
    "uz" = "sha256-81NxjFVqQCWq0t1o5DTG1PjSTkKPjWMf6ecKet0gFKM=";
    "vi" = "sha256-15nklkFB51GeuQG6Rw9VWM88oSsum2ctSe3Dsa/SChI=";
    "xh" = "sha256-z9NafjJNeAG54kf+7Sq4d7Zn+NtcMJehVvWbiwBEeb0=";
    "zh-CN" = "sha256-Q14bo+4C87+a8GG5012W2PpZZphdfIKngX7agfvTA2Q=";
    "zh-TW" = "sha256-HLGycW9QPE+kEFAg2BTZy9monv4KD5ERxmKFxO7xPyU=";
  };

  firefoxLanguagePacks = getAttrs firefoxLocales allFirefoxLanguagePacks;
in
stdenvNoCC.mkDerivation {
  pname = "firefox-pip-titles";
  version = firefoxVersion;

  srcs = mapAttrsToList (
    locale: hash:
    fetchurl {
      url = "https://ftp.mozilla.org/pub/firefox/releases/${firefoxVersion}/linux-x86_64/xpi/${locale}.xpi";
      inherit hash;
      name = locale + ".zip";
    }
  ) firefoxLanguagePacks;

  nativeBuildInputs = [
    unzip
    jq
  ];

  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack

    for src in $srcs; do
      lang=$(basename "$src" .zip)
      lang=''${lang#*-}
      echo "Unpacking $lang language pack..."
      unzip -q "$src" -d "$sourceRoot/$lang/"
    done

    runHook postUnpack
  '';

  buildPhase = ''
    runHook preBuild

    echo "Extracting Firefox PiP titles from language packs..."
    pip_prefix="pictureinpicture-player-title = "

    jq -Rn '
      [inputs | select(length > 0) | split("\t")]
      | map({(.[0]): .[1]})
      | add
    ' < <(
      for lang in ${escapeShellArgs firefoxLocales}; do
        pip_file="$sourceRoot/$lang/localization/$lang/toolkit/pictureinpicture/pictureinpicture.ftl"
        if [[ -s $pip_file ]]; then
          title="$(sed -n "s/^$pip_prefix//p" "$pip_file")"
          if [[ -n "$title" ]]; then
            >&2 echo "  $lang: $title"
            echo -e "$lang\t$title"
          else
            >&2 echo "  $lang: FAILED to find title"
          fi
        fi
      done
    ) > firefox.json

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp firefox.json $out

    runHook postInstall
  '';

  passthru.updateScript = writeShellApplication {
    name = "hyprpip-update";
    runtimeInputs = [ jq ];
    text = ''
      MAX_JOBS=8
      PACKAGE="''${1:-$PWD}/pkgs/firefoxPipTitles.nix"

      echo "Checking for Firefox version updates..."
      echo "Current version: ${firefoxVersion}"

      latest_version=$(nix search nixpkgs firefox --json | jq -r '.["legacyPackages.x86_64-linux.firefox"].version')
      echo "Latest version: $latest_version"

      version_updated=false
      if [[ "${firefoxVersion}" != "$latest_version" ]]; then
        echo "Version mismatch detected. Updating from ${firefoxVersion} to $latest_version..."
        version_updated=true
      else
        echo "Version ${firefoxVersion} is current, but checking hashes anyway..."
      fi

      if [[ ! -f "$PACKAGE" ]]; then
        echo "Error: Could not find hyprpip.nix file at $PACKAGE"
        echo "Please run this script from the repository root"
        exit 1
      fi

      if [[ "$version_updated" == "true" ]]; then
        echo "Updating firefoxVersion in $PACKAGE..."
        if ! sed -i "s| = \"${firefoxVersion}\"| = \"$latest_version\"|" "$PACKAGE"; then
          echo "Error: Failed to update firefoxVersion"
          exit 1
        fi

        if ! grep -q "firefoxVersion = \"$latest_version\";" "$PACKAGE"; then
          echo "Error: firefoxVersion was not updated correctly"
          exit 1
        fi
      fi

      temp_dir=$(mktemp -d)
      trap 'rm -rf "$temp_dir"' EXIT
      cd "$temp_dir"

      echo "Downloading language packs to compute new hashes..."

      declare -a languages=(
        ${concatStringsSep "\n        " (map (x: ''"${x}"'') (attrNames allFirefoxLanguagePacks))}
      )

      process_language() {
        local lang="$1"
        local latest_version="$2"
        local temp_dir="$3"

        url="https://ftp.mozilla.org/pub/firefox/releases/$latest_version/linux-x86_64/xpi/$lang.xpi"

        if hash=$(nix-prefetch-url "$url" 2>/dev/null); then
          sha256_hash="sha256-$(nix hash to-base64 --type sha256 "$hash" 2>/dev/null || echo "$hash")"
          echo "  $lang: $sha256_hash"
          echo "$lang:$sha256_hash" > "$temp_dir/$lang.success"
        else
          echo "  $lang: FAILED to download"
          echo "$lang:FAILED" > "$temp_dir/$lang.failed"
        fi
      }

      export -f process_language

      printf '%s\n' "''${languages[@]}" | xargs -I {} -P $MAX_JOBS bash -c 'process_language "$@"' _ {} "$latest_version" "$temp_dir"

      wait

      echo "All downloads completed. Updating file..."

      hashes_updated=0
      hashes_failed=0

      for result_file in "$temp_dir"/*.success; do
        if [[ -f "$result_file" ]]; then
          IFS=: read -r lang sha256_hash < "$result_file"
          if sed -i "s|\"$lang\" = \"sha256-.*\"|\"$lang\" = \"$sha256_hash\"|" "$PACKAGE"; then
            echo "  SUCCESS: Updated hash for $lang in file"
            hashes_updated=$((hashes_updated + 1))
          else
            echo "  WARNING: Failed to update hash for $lang in file"
          fi
        fi
      done

      for result_file in "$temp_dir"/*.failed; do
        if [[ -f "$result_file" ]]; then
          hashes_failed=$((hashes_failed + 1))
        fi
      done

      echo "Hash update completed!"
      echo ""
      echo "Update completed successfully!"
      echo ""
      echo "Summary:"

      if [[ "$version_updated" == "true" ]]; then
        echo "  Updated firefoxVersion: ${firefoxVersion} -> $latest_version"
      else
        echo "  Firefox version: $latest_version (unchanged)"
      fi
      echo "  Updated hashes: $hashes_updated"
      if [[ $hashes_failed -gt 0 ]]; then
        echo "  Failed downloads: $hashes_failed"
      fi

      echo "  Modified file: $PACKAGE"
      echo ""
      echo "Next steps:"
      echo "  1. Review the changes: git diff $PACKAGE"
      echo "  2. Test the build: nix build -f $PACKAGE"
      echo "  3. Commit if everything looks good"
    '';
  };

  meta = {
    description = "Firefox locales to Picture-in-Picture title map";
    homepage = "https://github.com/nadevko/dotfiles";
    license = licenses.eupl12;
    maintainers = with lib.maintainers; [ nadevko ];
    platforms = platforms.linux;
  };
}
