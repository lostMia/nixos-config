{
  lib,
  gitSupport ? true,
  fetchFromGitHub,
  rustPlatform,
  cmake,
  pandoc,
  pkg-config,
  zlib,
  installShellFiles,
}:
rustPlatform.buildRustPackage rec {
  pname = "waybar-timer";
  version = "0.3";

  src = fetchFromGitHub {
    owner = "jbirnick";
    repo = "https://github.com/jbirnick/waybar-timer";
    rev = "v${version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  };

  cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

  nativeBuildInputs = [
    cmake
    pkg-config
    installShellFiles
    pandoc
  ];
  buildInputs = [zlib];

  buildNoDefaultFeatures = true;
  buildFeatures = lib.optional gitSupport "git";

  outputs = [
    "out"
    "man"
  ];

  meta = with lib; {
    description = "A simple & customizable timer for your bar. Written by jbirnick";
    homepage = "https://github.com/jbirnick/waybar-timer";
    license = licenses.mit;
    mainProgram = "waybar-timer";
    maintainers = with maintainers; [
      lostMia
    ];
    platforms = platforms.unix;
  };
}
