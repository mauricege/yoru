{ lib, stdenv }:

let
  version = "1.0";
in
stdenv.mkDerivation {
  name = "azuki-${version}";
  src = ../../../../misc/fonts/azuki;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype
    chmod 755 $out/share/fonts/truetype/*.ttf
  '';
  meta = { };
}
