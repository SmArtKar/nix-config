{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "dm-langserver";
  version = "1.9";

  src = pkgs.fetchurl {
    name = "dm-langserver";
    url = "https://github.com/SpaceManiac/SpacemanDMM/releases/download/suite-${version}/dm-langserver";
    hash = "sha256-ruaudyOSJETqyJ8vCWLNc59v1mqXPMYxD77l3j4SC4w=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin 
    install -D $src $out/bin/dm-langserver
    chmod a+x $out/bin/dm-langserver
  '';
}
