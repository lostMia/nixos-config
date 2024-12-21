{
  rustPlatform,
  pkgs,
  lib,
  fetchFromGitHub,
}:
pkgs.rustPlatform.buildRustPackage {
  pname = "rmatrix";
  version = "3.0.0";
  cargoHash = "sha256-IDQB+PN5g/yX7XROSOFVi1R0eq7nWuC0WTc7ZEb/qbY=";

  src = fetchFromGitHub {
    owner = "Fierthraix";
    repo = "rmatrix";
    rev = "175b5a0f636ca2a2bf92f28e12472b4b156ebb99";
    hash = "sha256-R9YKUOGKgLnwIJVWwabDuEzB3AnEiyYH9KqYanA9O3Q=";
  };

  nativeBuildInputs = with pkgs; [nix coreutils rsync ncurses.dev];

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
