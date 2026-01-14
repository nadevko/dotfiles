{
  lib,
  stdenvNoCC,
  writeShellApplication,

  glib,
  fzf,

  historyFilePath ? ".fuzzmenu_history",
  historyFileSize ? 128,
}:
stdenvNoCC.mkDerivation {
  pname = "fuzzmenu";
  version = "0.1";

  buildInputs = [
    glib
    fzf
  ];

  dontUnpack = true;

  src = writeShellApplication {
    name = "fuzzmenu";
    text = ''
      pidfile="/tmp/fuzzmenu.pid"
      shell_name="$(basename "$SHELL")"
      if [[ -f "$pidfile" ]]; then
        exit 0
      fi
      echo >"$pidfile"
      trap 'rm -f "$pidfile"' EXIT

      declare -A apps
      declare -a sources=("$shell_name")
      IFS=':' read -ra dirs <<< "''${XDG_DATA_DIRS}"

      while read -r app_path; do
        app_name=$(basename "$app_path" .desktop)
        if [[ ! -v apps["$app_name"] ]]; then
          apps["$app_name"]="$app_path"
          sources+=("$app_name")
        fi
      done < <(for dir in "''${dirs[@]}"; do
        if [[ -d "$dir/applications" ]]; then
          find -L "$dir/applications" -name '*.desktop' 2>/dev/null
        fi
      done)

      choice="$(printf '%s\n' "''${sources[@]}" \
        | sort -u \
        | ${fzf}/bin/fzf --reverse --prompt="$ " \
        --bind "enter:accept-or-print-query,tab:replace-query" \
        --bind "ctrl-r:next-history,ctrl-s:prev-history" \
        --history="${historyFilePath}" --history-size="${toString historyFileSize}")"

      if [[ -z "$choice" ]]; then
        choice="$(tail -1 "${historyFilePath}")"
      fi

      if [[ -v apps["$choice"] ]]; then
        setsid ${glib}/bin/gio launch "''${apps[$choice]}" &
        exit 0
      fi

      if [[ "$choice" != "$shell_name" ]]; then
        eval "$choice"
      fi
      "$SHELL"
    '';
  };

  installPhase = ''
    mkdir --parent $out/bin
    cp $src/bin/fuzzmenu $out/bin/fuzzmenu
  '';

  meta = {
    description = "Firefox locales to Picture-in-Picture title map";
    homepage = "https://github.com/nadevko/dotfiles";
    license = lib.licenses.eupl12;
    maintainers = with lib.maintainers; [ nadevko ];
    platforms = lib.platforms.linux;
  };
}
