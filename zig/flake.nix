{
  description = "Flake utils demo";

  inputs = {
    nixpkgs.url =  "github:nixos/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils"; 
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        devShell = pkgs.mkShellNoCC {
          name = "zig shell";
          packages = with pkgs; [
            zig
            zls
          ];
        };
      }
    );
}
