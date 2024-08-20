/*
this is based on https://github.com/NixOS/nixpkgs/issues/209660

I can't get racket with the racket-langserver working,
must ask nixos community for help
*/
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
      overlay = final: prev: {
        racket = prev.racket.overrideAttrs (finalAttrs: prevAttrs: {
          # configureFlags = /* prev.racket.configureFlags ++ */ ["--enable-prefix"];
          # DYLD_LIBRARY_PATH = final.symlinkJoin {
          #   name = "DYLD_LIBRARY_PATH";
          #   paths = [prevAttrs.LD_LIBRARY_PATH (final.lib.makeLibraryPath [final.xorg.libX11])];
          # }; # ++ prevAttrs.libPath;
          DYLD_LIBRARY_PATH = "${final.xorg.libX11}";
          configureFlags = prevAttrs.configureFlags ++ ["--enable-prefix"];
        });
      };
      myPkgs = pkgs.extend overlay;

    in {
      devShells = {
        default = pkgs.mkShell {
          name = "racket shell";
          buildInputs = with pkgs; [racket];
          LD_LIBRARY_PATH   = "${pkgs.xorg.libX11}";
          DYLD_LIBRARY_PATH = "${pkgs.xorg.libX11}";
          shellHook = ''
            echo "run 'raco pkg install racket-langserver'"
            echo "nothing works here, dont use this flake D:"
            # raco pkg install racket-langserver
            # export ;
          '';
        };
      };
    });
}
# export DYLD_LIBRARY_PATH="${myPkgs.racket.libPath}"

