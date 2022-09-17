{ lib, stdenv }:

let
  version = "1.0";
in
stdenv.mkDerivation {
  name = "aesthetic-iosevka-${version}";
  src = "../../../../misc/fonts/AestheticIosevka";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/*.ttf $out/share/fonts/truetype
    chmod 755 $out/share/fonts/truetype/*.ttf
  '';
  meta = { };
}
