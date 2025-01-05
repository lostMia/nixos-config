{
  description = "This is a template shell-script!";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        my-name = "shellscript";
        my-buildInputs = with pkgs; [figlet lolcat];
        my-script = pkgs.writeShellScriptBin my-name ''
          figlet Well this certainly is something! pwp | lolcat
        '';
      in rec {
        defaultPackage = packages.shellscript;
        packages.shellscript = pkgs.symlinkJoin {
          name = my-name;
          paths = [my-script] ++ my-buildInputs;
          buildInputs = [pkgs.makeWrapper];
          postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";
        };
      }
    );
}
