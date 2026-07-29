{
  inputs = {
    disko.url = "github:nix-community/disko/latest";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixos.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    noctalia.url = "github:noctalia-dev/noctalia";
    nur.url = "github:nix-community/NUR";
    nvf.url = "github:NotAShelf/nvf";
    sops-nix.url = "github:mic92/sops-nix";
  };
  outputs =
    {
      disko,
      emacs-overlay,
      home-manager,
      neovim-nightly-overlay,
      nix-index-database,
      nixos,
      nixpkgs,
      noctalia,
      nvf,
      self,
      sops-nix,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      makeHomeConfiguration =
        {
          user,
          modules,
          pkgs,
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          modules = modules ++ [ ./home-manager/${user} ];
          inherit pkgs;
        };
      makePerSystemHomeConfiguration =
        {
          user,
          system,
          modules,
          pkgs,
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs user; };
          modules = modules ++ [ ./home-manager/${user}/${system}.nix ];
          inherit pkgs;
        };
      makeSystemConfiguration =
        {
          modules,
          nixpkgs,
          system,
        }:
        nixpkgs.lib.nixosSystem {
          modules = modules ++ [ ./nixpkgs/${system} ];
        };
      makePerUserSystemConfiguration =
        {
          modules,
          nixpkgs,
          system,
          user,
        }:
        nixpkgs.lib.nixosSystem {
          modules = modules ++ [
            ./nixpkgs/${system}
            ./nixpkgs/${user}/${system}.nix
          ];
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
        "gabriel" = makeHomeConfiguration {
          modules = [
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          user = "gabriel";
        };
        "gabriel@nix-notebook" = makePerSystemHomeConfiguration {
          system = "nix-notebook";
          modules = [
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          user = "gabriel";
        };
        "gabriel@nix-pc" = makePerSystemHomeConfiguration {
          system = "nix-pc";
          modules = [
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          user = "gabriel";
        };
      };
      nixosConfigurations = {
        iso = makeSystemConfiguration {
          modules = [
            disko.nixosModules.disko
          ];
          inherit nixpkgs;
          system = "iso";
        };
        nix-notebook = makePerUserSystemConfiguration {
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
          inherit nixpkgs;
          system = "nix-notebook";
          user = "gabriel";
        };
        nix-pc = makePerUserSystemConfiguration {
          system = "nix-pc";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
          inherit nixpkgs;
          user = "gabriel";
        };
        nix-server = makePerSystemHomeConfiguration {
          system = "nix-server";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
          nixpkgs = nixos;
          user = "gabriel";
        };
        overlays.default = finalAttrs: previousAttrs: {
          gopass-pass = finalAttrs.callPackage ./packages/gopass-pass { };
        };
      };
    };
}
