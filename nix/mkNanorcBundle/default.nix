{ lib, stdenv, fetchFromGitHub, nix-update-script }:
{ owner, repo, version, hash, license }@extra:
stdenv.mkDerivation {
  pname = "${owner}-nanorc";
  inherit version;
  meta = {
    description = "Improved Nano Syntax Highlighting Files";
    homepage = "https://github.com/${owner}/${repo}";
    inherit license;
    platforms = lib.platforms.all;
  };
  src = fetchFromGitHub {
    inherit owner repo hash;
    rev = version;
  };
  dontBuild = true;
  dontConfigure = true;
  installPhase = ''
    mkdir --parent $out/share/nano/extra
    cp * $out/share/nano
  '';
  passthru.updateScript = nix-update-script { };
} // extra
