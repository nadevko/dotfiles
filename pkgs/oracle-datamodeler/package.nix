{
  lib,
  stdenv,
  fetchurl,
  openjdk17,
  javaPackages,
  makeDesktopItem,
  copyDesktopItems,
  unzip,
  makeWrapper,
  writeShellApplication,
  inputs,
}:

let
  java = openjdk17.override {
    enableJavaFX = true;
    openjfx_jdk = javaPackages.openjfx17;
  };
in

stdenv.mkDerivation rec {
  pname = "oracle-datamodeler";
  version = "24.3.1.351.0831";

  src = fetchurl {
    url = "https://download.oracle.com/otn_software/java/sqldeveloper/datamodeler-${version}-no-jre.zip";
    hash = "sha256-PG4BGJ+9fw+vZpVaGvySRH9PsgRTuf9JH0wBT4OzmvU=";
  };

  nativeBuildInputs = [
    unzip
    copyDesktopItems
    makeWrapper
  ];
  buildInputs = [ java ];

  sourceRoot = "datamodeler";

  postUnpack = ''
    find ${sourceRoot} \( -iname "*.exe" -o -iname "*.dll" \) -delete
    rm -f ${sourceRoot}/datamodeler/bin/datamodeler-Darwin.conf
    rm -rf ${sourceRoot}/modules/javafx
    rm -rf ${sourceRoot}/jdev/extensions/oracle.webbrowser.osx
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/licenses/${pname}
    mv jdev/extensions/oracle.jdeveloper.git/license/License.txt $out/share/licenses/${pname}/JDEVELOPER-LICENSE
    rmdir jdev/extensions/oracle.jdeveloper.git/license
    mv jdev/extensions/oracle.jdeveloper.subversion/licenses/license.txt $out/share/licenses/${pname}/JDEV-SUBVERSION-LICENSE
    mv jdev/extensions/oracle.jdeveloper.subversion/licenses/COPYING $out/share/licenses/${pname}/JDEV-SUBVERSION-COPYING
    rmdir jdev/extensions/oracle.jdeveloper.subversion/licenses
    mv svnkit/licenses/COPYING $out/share/licenses/${pname}/SVNKIT-COPYING
    mv svnkit/licenses/license.txt $out/share/licenses/${pname}/SVNKIT-LICENSE
    mv svnkit/licenses/* $out/share/licenses/${pname}
    rmdir svnkit/licenses
    cp ${./LICENSE} $out/share/licenses/${pname}/LICENSE

    mkdir -p $out/libexec/${pname}
    cp -r . $out/libexec/${pname}/

    chmod +x $out/libexec/${pname}/datamodeler/bin/datamodeler
    chmod +x $out/libexec/${pname}/ide/bin/launcher.sh

    mkdir -p $out/share/pixmaps
    cp icon.png $out/share/pixmaps/${pname}.png

    mkdir -p $out/bin
    makeWrapper $out/libexec/${pname}/datamodeler/bin/datamodeler $out/bin/${pname} \
      --set JAVA_HOME "${java}" \
      --add-flags "-Dpolyglot.engine.WarnInterpreterOnly=false" \
      --run 'export XDG_DATA_HOME=''${XDG_DATA_HOME:-$HOME/.local/share}'

    runHook postInstall
  '';

  postPatch = ''
        substituteInPlace datamodeler/bin/datamodeler \
          --replace-fail 'GetUserHomeDirName()
    {
        echo ".oraclesqldeveloperdatamodeler"
    }' 'GetUserHomeDirName()
    {
        echo "''${XDG_DATA_HOME:-$HOME/.local/share}/oracle-datamodeler"
    }'

        substituteInPlace datamodeler/bin/datamodeler \
          --replace-fail 'GetUserConfRootDirName()
    {
        echo "`GetUserHomeDirName`"
    }' 'GetUserConfRootDirName()
    {
        local userHome="`GetUserHomeDirName`"
        mkdir -p "$userHome/types" 2>/dev/null || true
        echo "$userHome"
    }'
  '';

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = "Oracle SQL Database Modeling";
      comment = "A graphical tool for database modeling.";
      exec = pname;
      icon = pname;
      type = "Application";
      categories = [ "Development" ];
      startupNotify = true;
      startupWMClass = "sun-awt-X11-XFramePeer";
    })
  ];

  dontStrip = true;

  passthru.updateScript = writeShellApplication {
    name = "update-oracle-datamodeler";
    runtimeInputs = [ ];
    text = ''
      PACKAGE="''${1:-$PWD}/pkgs/oracle-datamodeler/package.nix"

      echo "Checking for Oracle Data Modeler version updates..."
      echo "Current version: ${version}"

      latest_version=$(curl -s "https://www.oracle.com/database/sqldeveloper/technologies/sql-data-modeler/download/" | grep -oP 'Version \K[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)

      if [[ -z "$latest_version" ]]; then
        echo "Error: Could not determine latest version"
        exit 1
      fi

      echo "Latest version: $latest_version"

      if [[ "${version}" == "$latest_version" ]]; then
        echo "Version ${version} is current."
        exit 0
      fi

      echo "Version mismatch detected. Updating from ${version} to $latest_version..."

      if [[ ! -f "$PACKAGE" ]]; then
        echo "Error: Could not find package.nix at $PACKAGE"
        exit 1
      fi

      echo "Downloading new version to compute hash..."
      new_sha256_hex=$(nix-prefetch-url "https://download.oracle.com/otn_software/java/sqldeveloper/datamodeler-$latest_version-no-jre.zip" 2>/dev/null)

      if [[ -z "$new_sha256_hex" ]]; then
        echo "Error: Could not download new version"
        exit 1
      fi

      echo "Downloaded, converting hash format..."
      new_sha256_sri=$(nix hash convert --hash-algo sha256 --to sri "$new_sha256_hex")

      if [[ -z "$new_sha256_sri" ]]; then
        echo "Error: Could not convert hash to SRI format"
        exit 1
      fi

      echo "New hash (hex): $new_sha256_hex"
      echo "New hash (SRI): $new_sha256_sri"

      if ! sed -i "s|version = \"${version}\"|version = \"$latest_version\"|" "$PACKAGE"; then
        echo "Error: Failed to update version"
        exit 1
      fi

      if ! sed -i "s|hash = \"sha256-[a-zA-Z0-9+/=]*\"|hash = \"$new_sha256_sri\"|" "$PACKAGE"; then
        echo "Error: Failed to update hash"
        exit 1
      fi

      echo "Update completed successfully!"
      echo ""
      echo "Summary:"
      echo "  Updated version: ${version} -> $latest_version"
      echo "  Updated hash"
      echo "  Modified file: $PACKAGE"
    '';
  };

  meta = with lib; {
    description = "Data modeling and database design tool from Oracle";
    homepage = "https://www.oracle.com/tools/datamodeler/";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = [ inputs.self.lib.maintainers.nadevko ];
  };
}
