{
  lib,
  stdenvNoCC,
  fetchurl,
}:
{ githubID, githubAvatarHash }:
stdenvNoCC.mkDerivation {
  pname = "avatar";
  version = "2";
  src = fetchurl {
    url = "https://avatars.githubusercontent.com/u/${githubID}?v=4";
    hash = githubAvatarHash;
  };
  dontUnpack = true;
  installPhase = ''
    install -Dm644 $src $out
  '';
  meta = with lib; {
    description = "Github avatar file";
    homepage = "https://github.com/nadevko";
    license = licenses.cc0;
    maintainers = with maintainers; [ nadevko ];
    platforms = platforms.all;
  };
}
