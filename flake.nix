{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , treefmt-nix
    , ...
    }:
    {
      overlay = final: prev:
        let
          pkgs = nixpkgs.legacyPackages.${prev.system};
        in
        rec { };
    }
    // flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          overlays = [ self.overlay ];
          inherit system;
        };

        devDeps = with pkgs;
          [
            nodejs
            yarn
          ]
          ++ lib.optionals pkgs.stdenv.isLinux [
            xvfb-run
          ];

        # treefmt: single source of truth for formatting (elm, nix, web).
        treefmt = treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.elm-format.enable = true;
          programs.nixpkgs-fmt.enable = true;
          programs.prettier.enable = true;
        };

        # Pure Elm compilation of the resume source. The full parcel bundle +
        # electron PDF render + Pages deploy need node_modules / a headless
        # display and stay in the workflow; this check guards the Elm source.
        build = pkgs.stdenv.mkDerivation {
          pname = "resume";
          version = "1.0.0";
          src = ./.;

          nativeBuildInputs = [ pkgs.elmPackages.elm ];

          configurePhase = pkgs.elmPackages.fetchElmDeps {
            elmPackages = import ./elm-srcs.nix;
            elmVersion = "0.19.1";
            registryDat = ./registry.dat;
          };

          buildPhase = ''
            elm make src/Main.elm --output=resume.html
          '';

          installPhase = ''
            mkdir -p $out
            cp resume.html $out/
          '';
        };
      in
      {
        packages.default = build;

        checks = {
          inherit build;
          formatting = treefmt.config.build.check self;
        };

        formatter = treefmt.config.build.wrapper;

        # `nix develop`
        devShell = pkgs.mkShell {
          buildInputs = devDeps;
          shellHook = ''
            export DISPLAY=:9.0
          '';
        };
      });
}
