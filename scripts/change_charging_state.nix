{pkgs ? import <nixpkgs> {}}: {
  pkgs.stdenv.mkDerivation = {
    name = "change_charging_state";

    buildInputs = [pkgs.coreutils];

    installPhase = ''
      mkdir -p $out/bin
      cat << EOF > $out/bin/$(name)
      #!/bin/bash
      echo "Hello from Nix!"
      EOF
      chmod +x $out/bin/$(name)
    '';
  };
}
