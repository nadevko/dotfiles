{
  inputs,
  lib,
  stdenv,
  fetchurl,
  unzip,
}:
stdenv.mkDerivation {
  name = "gost-fonts";
  srcs = [
    (fetchurl {
      url = "http://stroydocs.com/web/info/gost_fonts/files/GOST_type_A.zip";
      hash = "sha256-R6JxAeUi4JNUNdLqqebmg4Lc0QRf3OcaZU6gmC7gkYQ=";
    })
    (fetchurl {
      url = "http://stroydocs.com/web/info/gost_fonts/files/GOST_type_B.zip";
      hash = "sha256-XLADDt2gW0wxaZbJJd/J7Y27hv8DkG9FZPDwJI79myg=";
    })
    (fetchurl {
      url = "https://stroydocs.com/web/info/gost_fonts/files/isocpeur.zip";
      hash = "sha256-RbkrLkOySqICXuB/BkW+EbVckm8tYbUrPztiYU5G9bI=";
    })
  ];
  unpackPhase = ''
    for src in $srcs; do
      ${unzip}/bin/unzip -j $src
    done
  '';
  dontBuild = true;
  installPhase = ''
    install -d $out/share/fonts/gost
    install -m655 *.ttf $out/share/fonts/gost
  '';

  meta = {
    description = "The russian engineering fonts by Ascon and Autodesk";
    homepage = "https://stroydocs.com/info/gost_fonts";
    license = {
      tag = "custom";
      shortName = "copyright";
      fullName = "Copyright (C) All rights reserved";
      url = "https://en.wikipedia.org/w/index.php?title=All_rights_reserved";
      free = false;
    };
    maintainers = with inputs.self.lib.maintainers; [ nadevko ];
    platforms = lib.platforms.linux;
  };
}
