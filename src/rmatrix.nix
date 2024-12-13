{
  stdenv,
  pkgs,
  lib,
  fetchFromGitHub,
}:
pkgs.stdenv.mkDerivation {
  pname = "rmatrix";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "Fierthraix";
    repo = "rmatrix";
    rev = "175b5a0f636ca2a2bf92f28e12472b4b156ebb99";
    hash = lib.fakeSha256;
  };

  buildInputs = [
    pkgs.cargo
  ];

  buildPhase = ''
    cargo install r-matrix
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv chord $out/bin
  '';

  meta = with lib; {
    description = "rust port of cmatrix";
    mainProgram = "rmatrix";
    maintainers = with maintainers; [
      Fierthraix
    ];
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
