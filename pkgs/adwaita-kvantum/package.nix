{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
let
  owner = "GabePoel";
  themeName = "KvLibadwaita";
in
stdenvNoCC.mkDerivation {
  pname = themeName;
  version = "0-unstable-2025-09-13";

  src = fetchFromGitHub {
    inherit owner;
    repo = themeName;
    rev = "1f4e0bec44b13dabfa1fe4047aa8eeaccf2f3557";
    hash = "sha256-jCXME6mpqqWd7gWReT04a//2O83VQcOaqIIXa+Frntc=";
  };
  dontBuild = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share
    cp --recursive ./src $out/share/Kvantum
    runHook postInstall
  '';
  passthru.themeName = themeName;

  meta = {
    description = "Libadwaita style theme for Kvantum. Based on Colloid-kde.";
    homepage = "https://github.com/${owner}/${themeName}";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ nadevko ];
  };
}
