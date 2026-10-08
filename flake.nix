{
  inputs = {
    disko.url = "github:nix-community/disko/latest";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixos.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-zotero.url = "github:NixOS/nixpkgs/8d5d270900d3fc75655ea2d9d248b234f6631439";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    noctalia.url = "github:noctalia-dev/noctalia";
    nur.url = "github:nix-community/NUR";
    nvf.url = "github:NotAShelf/nvf";
    sops-nix.url = "github:mic92/sops-nix";
    umbriel.url = "github:noctalia-dev/umbriel";
  };
  outputs =
    {
      disko,
      emacs-overlay,
      home-manager,
      neovim-nightly-overlay,
      nix-index-database,
      nixos,
      nixos-unstable,
      nixpkgs-zotero,
      nixpkgs,
      noctalia,
      nvf,
      self,
      sops-nix,
      umbriel,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      makeHome =
        {
          modules ? [ ],
          pkgs,
          system ? null,
          user,
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              _module.args = {
                inherit inputs user;
              };
            }
            (if system == null then ./home-manager/${user} else ./home-manager/${user}/${system}.nix)
          ]
          ++ modules;
        };
      makeSystem =
        {
          modules ? [ ],
          nixpkgs,
          system,
          user ? null,
        }:
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              _module.args = {
                inherit inputs;
              };
            }
            ./nixpkgs/${system}
          ]
          ++ nixpkgs.lib.optional (user != null) ./nixpkgs/${user}/${system}.nix
          ++ modules;
        };
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixd
              nixfmt
            ];
          };
        }
      );
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
      homeConfigurations = {
        "gabriel" = makeHome {
          modules = [
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          user = "gabriel";
        };
        "gabriel@nix-notebook" = makeHome {
          system = "nix-notebook";
          modules = [
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
            umbriel.homeModules.default
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          user = "gabriel";
        };
        "gabriel@nix-pc" = makeHome {
          system = "nix-pc";
          modules = [
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
            umbriel.homeModules.default
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          user = "gabriel";
        };
      };
      nixosConfigurations = {
        iso = makeSystem {
          modules = [
            disko.nixosModules.disko
          ];
          inherit nixpkgs;
          system = "iso";
        };
        nix-notebook = makeSystem {
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
          inherit nixpkgs;
          system = "nix-notebook";
          user = "gabriel";
        };
        nix-pc = makeSystem {
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
          inherit nixpkgs;
          system = "nix-pc";
          user = "gabriel";
        };
        nix-server = makeSystem {
          system = "nix-server";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
          nixpkgs = nixos;
          user = "gabriel";
        };
      };
      overlays.default = finalAttrs: previousAttrs: {
        antigravity-acp = finalAttrs.callPackage ./packages/antigravity-acp { };
        caveman = finalAttrs.callPackage ./packages/caveman { };
        emacs-skills = finalAttrs.callPackage ./packages/emacs-skills { };
        agy_acp_server = finalAttrs.antigravity-acp;
        gopass-pass = finalAttrs.callPackage ./packages/gopass-pass { };
        navidrome-lyrics-plugin = finalAttrs.callPackage ./packages/navidrome-lyrics-plugin { };
        librewolf = inputs.nixos-unstable.legacyPackages.${finalAttrs.stdenv.hostPlatform.system}.librewolf;
        tor-browser =
          inputs.nixos-unstable.legacyPackages.${finalAttrs.stdenv.hostPlatform.system}.tor-browser;
        zotero = inputs.nixpkgs-zotero.legacyPackages.${finalAttrs.stdenv.hostPlatform.system}.zotero;
      };
    };
}
