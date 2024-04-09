{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, utils, nixpkgs }: 
  utils.lib.eachDefaultSystem (system: 
  let pkgs = nixpkgs.legacyPackages.${system}; in {
    devShell = pkgs.mkShell {
      name = "c-shell";
      buildInputs = with pkgs; [
        clang
        clang-tools
      ];
    };
  });
}
