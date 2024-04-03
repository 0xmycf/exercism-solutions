{
  inputs = {
    nixpkgs.url =  "github:nixos/nixpkgs/23.11";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          typescript
          nodePackages_latest.typescript-language-server
          nodePackages.nodejs
        ];
      };
    }
  );
}
