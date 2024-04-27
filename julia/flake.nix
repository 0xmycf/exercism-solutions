{
  description = "Flake utils demo";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url =  "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (julia-bin)#.withPackages ["LanguageServer"])
            # julia-bin
          ];
        };
      }
    );
}
