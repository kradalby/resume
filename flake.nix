{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: let
    infrastructureVersion =
      if (self ? shortRev)
      then self.shortRev
      else "dev";
  in
    {
      overlay = final: prev: let
        pkgs = nixpkgs.legacyPackages.${prev.system};
      in rec {};
    }
    // flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        overlays = [self.overlay];
        inherit system;
      };
      devDeps = with pkgs;
        [
          nodejs
          nodePackages.yarn
          # x11-xkb-utils
          # x11-apps
          # clang
          # libdbus-1-dev
          # # libgtk2.0-dev
          # libnotify-dev
          # libgconf2-dev
          # libasound2-dev
          # libcap-dev
          # libcups2-dev
          # libxtst-dev
          # libxss1
          # libnss3-dev
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          xvfb-run
        ];
    in rec {
      # `nix develop`
      devShell = pkgs.mkShell {
        buildInputs = devDeps;
        shellHook = ''
          export DISPLAY=:9.0
        '';
      };
    });
}
