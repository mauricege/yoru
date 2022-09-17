{ lib, stdenv }:

let
  version = "1.0";
in
stdenv.mkDerivation {
  name = "icomoon-${version}";
  src = ../../../../misc/fonts/icomoon;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype
    chmod 755 $out/share/fonts/truetype/*.ttf
  '';
  meta = { };
}
