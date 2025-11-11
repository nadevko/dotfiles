{
  lib,
  stdenvNoCC,
  fetchurl,
  inputs,

  githubID,
  githubAvatarHash,
}:
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
  meta = {
    description = "Github avatar file";
    homepage = "https://github.com/nadevko";
    license = lib.licenses.cc0;
    maintainers = with inputs.self.lib.maintainers; [ nadevko ];
    platforms = lib.platforms.all;
  };
}
