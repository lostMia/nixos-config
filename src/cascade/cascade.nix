{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "cascade-theme";

  src = pkgs.fetchFromGitHub {
    owner = "cascadefox";
    repo = "cascade";
    rev = "8fbe98934fa58f934f7ed5253367396519b320a4";
    sha256 = "sha256-GMXSpNaShNu/Bce6TTnlgzGHV8MhHRVICv8hJqMi70w=";
  };

  patches = [
    ./cascade-theme-modified.patch
  ];

  installPhase = ''
    cp chrome $out/ -r
  '';
}
