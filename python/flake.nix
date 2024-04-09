{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python311;
      bi = with pkgs; [
          python
          python311Packages.pytest
        ];
      run-tests = pkgs.writeShellScriptBin "run-tests" ''
        #!${pkgs.bash}/bin/bash
        ${python}/bin/python -m pytest -o markers=test $1
      '';
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodePackages_latest.pyright
          run-tests
        ] ++ bi;
      };

    });
}
