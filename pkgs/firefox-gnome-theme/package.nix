{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "143";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-0E3TqvXAy81qeM/jZXWWOTZ14Hs1RT7o78UyZM+Jbr4=";
  };

  patches = [ ./0001-Remove-custom-css-loads.patch ];

  installPhase = ''
    mkdir --parent $out/lib/firefox/chrome
    cp --recursive theme $out/lib/firefox/chrome
    install -Dm644 userContent.css $out/lib/firefox/chrome
    install -Dm644 userChrome.css $out/lib/firefox/chrome
  '';

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
    maintainers = with maintainers; [ nadevko ];
    platforms = platforms.unix;
  };
}
