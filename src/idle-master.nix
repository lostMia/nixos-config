{
  description = "Idle Master application for getting steam cards.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {
    self,
    nixpkgs,
    lib,
    fetchFromGitHub,
    buildDotnetModule,
  }: {
    packages.x86_64-linux.idle_master_extended = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in
      pkgs.dotnetPackages.buildDotnetModule rec {
        pname = "idle_master_extended";
        version = "1.10.0";

        src = fetchFromGitHub {
          owner = "JonasNilson";
          repo = pname;
          rev = "v${version}";
          sha256 = "1jp5vvw7773jy6r311rmqpisq0v3min769m6c6d6m7w30hal5ia0";
        };

        projectFile = "IdleMasterExtended/Source/IdleMasterExtended.csproj";

        meta = with pkgs.lib; {
          homepage = "https://github.com/JonasNilson/idle_master_extended";
          description = "Idle Master Extended for farming Steam cards";
          license = licenses.mit;
          maintainers = [maintainers.lostmia];
        };
      };
  };
}
