{
  inputs = {
    disko.url = "github:nix-community/disko/latest";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixos.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    niri-nix.url = "git+https://codeberg.org/BANanaD3V/niri-nix";
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
      niri-nix,
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
      mkHomeConfiguration =
        {
          username,
          module ? ./home-manager/${username}.nix,
          pkgs,
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs username; };
          modules = [
            nix-index-database.homeModules.default
            nvf.homeModules.default
            sops-nix.homeModules.default
            module
          ];
          inherit pkgs;
        };
      mkPerHostHomeConfiguration =
        {
          username ? "gabriel",
          host,
          module ? ./home-manager/${host}.nix,
          pkgs,
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs username; };
          modules = [
            niri-nix.homeModules.default
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
            sops-nix.homeModules.default
            module
          ];
          inherit pkgs;
        };
      mkSystemConfiguration =
        {
          username ? "gabriel",
          fullName ? "Gabriel Santos",
          host,
          system ? "x86_64-linux",
          module ? ./nixpkgs/${host}.nix,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            module
          ];
          specialArgs = {
            inherit
              fullName
              host
              system
              username
              ;
          };
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
        "gabriel" = mkHomeConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          username = "gabriel";
        };
        "gabriel@nix-pc" = mkPerHostHomeConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          host = "nix-pc";
        };
        "gabriel@nix-notebook" = mkPerHostHomeConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          host = "nix-notebook";
        };
      };
      nixosConfigurations = {
        iso = mkSystemConfiguration {
          host = "iso";
        };
        nix-pc = mkSystemConfiguration {
          host = "nix-pc";
        };
        nix-notebook = mkSystemConfiguration {
          host = "nix-notebook";
        };
        nix-server = mkSystemConfiguration {
          host = "nix-server";
        };
      };
      overlays.default = finalAttrs: previousAttrs: {
        caveman = finalAttrs.callPackage ./packages/caveman { };
        gopass-pass = finalAttrs.callPackage ./packages/gopass-pass { };
      };
    };
}
