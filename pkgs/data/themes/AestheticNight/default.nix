{ lib, stdenv, fetchFromGitHub, gnome, gtk-engine-murrine }:

let
  pname = "aesthetic-night-gtk";
  version = "1ded75efcc4554ee873dd184b02a1178e715b493";
in
stdenv.mkDerivation {
  inherit pname;
  inherit version;
  src = fetchFromGitHub {
    owner = "rxyhn";
    repo = "AestheticStuff";
    rev = version;
    hash = "sha256-lZsYKmg49yvsXBFPYKMNoejarYo5XNA7CnfmXL9rucI=";
  };

  propagatedUserEnvPkgs = [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes
    cp -r $src/gtk/Aesthetic-Night/* $out/share/themes
  '';
  meta = {
    badPlatforms = [ "aarch64-darwin" "x86_64-darwin" ];
  };
}


