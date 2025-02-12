# playerctl-shift.nix

{ stdenv, fetchFromGitHub, git, python311, playerctl }:

# Utility to swtich curently active playerctl source

stdenv.mkDerivation {
  pname = "playerctl-shift";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "IngoMeyer441";
    repo = "playerctl-shift";
    rev = "v0.1.0";
    sha256 = "0017c0rxcnf990jkri5gz50ns05mhpwc6lqzqkbr9yw32dbxbb2g";
  };

  buildInputs = [
    git
    python311
    playerctl
  ];

  preConfigure = ''
    substituteInPlace Makefile \
      --replace "\''$(DESTDIR)" "$out" \
  '';

  buildPhase = ''
    runHook preBuild
    make install
    runHook postBuild
  '';
  
  /*
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp playerctl-shift $out/bin
    runHook postInstall
  '';
  */
}
