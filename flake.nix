{
  description = "Little daemon that runs piped commands";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    forAllSystems = nixpkgs.lib.genAttrs systems;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    homeManagerModules = {
      default = self.homeManagerModules.scr;
      scr = import ./home-manager/modules/services/scr.nix { inherit self; };
    };
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (pkgs) lib;
    in {
      default = self.packages.${system}.scr;
      scr = pkgs.stdenv.mkDerivation {
        name = "scr";
        pname = "scr";
        src = ./.;

        nativeBuildInputs = with pkgs; [ makeWrapper ];

        installPhase = ''
          mkdir -p $out/bin
          install -t $out/bin -m 755 scr
        '';

        postFixup = with pkgs; ''
          for bin in $out/bin/*; do
            wrapProgram $bin \
              --set PATH ${lib.makeBinPath [
                coreutils
                xdg-user-dirs

                grim
                maim
                slurp

                wl-clipboard
                xclip

                sxiv
                imv
              ]}
          done
        '';
      };
    });
  };
}
