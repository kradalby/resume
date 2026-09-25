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
    # Not eachDefaultSystem: nixpkgs 26.11 dropped x86_64-darwin and throws on eval.
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ]
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        devDeps = with pkgs;
          [
            nodejs
            yarn
            prek
            gnumake
          ]
          ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
            xvfb-run
          ];

        # treefmt: single source of truth for formatting (elm, nix, web).
        treefmt = treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.elm-format.enable = true;
          programs.nixpkgs-fmt.enable = true;
          programs.prettier.enable = true;
        };

        # Full parcel bundle (Elm + SCSS + assets) built entirely in Nix.
        # JS deps come from the yarn.lock via fetchYarnDeps; Elm packages via
        # fetchElmDeps. The electron PDF render + Pages deploy remain in the
        # workflow (they need a headless browser), but the buildable artifact
        # — the static site — is reproducible here.
        build = pkgs.stdenv.mkDerivation {
          pname = "resume";
          version = "1.0.0";
          # Parcel names index bundles after the project dir; a fixed name
          # keeps the store hash out of the published asset names.
          src = builtins.path { path = ./.; name = "resume"; };

          nativeBuildInputs = with pkgs; [
            yarn
            fixup-yarn-lock
            nodejs
            elmPackages.elm
          ];

          yarnOfflineCache = pkgs.fetchYarnDeps {
            yarnLock = ./yarn.lock;
            hash = "sha256-N6tj5o/8zpifzmkEs9vDATu2Z884G+fjGzbKGxwgfzk=";
          };

          configurePhase = ''
            runHook preConfigure
            export HOME="$TMPDIR"
            yarn config --offline set yarn-offline-mirror "$yarnOfflineCache"
            fixup-yarn-lock yarn.lock
            # --ignore-scripts: electron-pdf (binary download) and node-sass
            # (native build) postinstalls aren't needed to build the bundle and
            # fail offline. SCSS is compiled by @parcel/transformer-sass
            # (dart-sass); the PDF render is a separate publish step.
            yarn install --offline --frozen-lockfile --ignore-engines \
              --ignore-scripts --no-progress --non-interactive
            patchShebangs node_modules/

            # @parcel/transformer-elm resolves the local npm `elm` wrapper,
            # whose binary-download postinstall we skipped. Point it (and the
            # other Elm CLIs) at the Nix-provided binaries.
            ln -sf ${pkgs.elmPackages.elm}/bin/elm node_modules/.bin/elm
            ln -sf ${pkgs.elmPackages.elm}/bin/elm node_modules/elm/bin/elm

            ${pkgs.elmPackages.fetchElmDeps {
              elmPackages = import ./elm-srcs.nix;
              elmVersion = "0.19.2";
              registryDat = ./registry.dat;
            }}
            runHook postConfigure
          '';

          buildPhase = ''
            runHook preBuild
            rm -rf elm-stuff
            node_modules/.bin/parcel build --public-url "./" --no-scope-hoist \
              --dist-dir dist src/index.html
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p $out
            cp -r dist/* $out/
            runHook postInstall
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
        devShells.default = pkgs.mkShell {
          buildInputs = devDeps;
          shellHook = ''
            export DISPLAY=:9.0
          '';
        };
      });
}
