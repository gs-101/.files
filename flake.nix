{
  inputs = {
    disko.url = "github:nix-community/disko/latest";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia-qs.url = "github:noctalia-dev/noctalia-qs";
    nur.url = "github:nix-community/NUR";
    nvf.url = "github:NotAShelf/nvf";
  };
  outputs =
    {
      disko,
      emacs-overlay,
      home-manager,
      neovim-nightly-overlay,
      niri,
      nix-index-database,
      nixpkgs,
      noctalia,
      noctalia-qs,
      nvf,
      ...
    }@inputs:
    let
      pkgsX86Linux = nixpkgs.legacyPackages.x86_64-linux;
      mkHomeConfiguration =
        {
          username,
          module ? ./home-manager/${username}.nix,
          pkgs ? pkgsX86Linux,
        }:
        {
          extraSpecialArgs = { inherit inputs username; };
          modules = [
            nix-index-database.homeModules.default
            nvf.homeModules.default
            module
          ];
          inherit pkgs;
        };
      mkPerHostHomeConfiguration =
        {
          username ? "gabriel",
          host,
          module ? ./home-manager/${host}.nix,
          pkgs ? pkgsX86Linux,
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs username; };
          modules = [
            niri.homeModules.niri
            nix-index-database.homeModules.default
            noctalia.homeModules.default
            nvf.homeManagerModules.default
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
      homeConfigurations = {
        "gabriel" = mkHomeConfiguration { username = "gabriel"; };
        "gabriel@nix-pc" = mkPerHostHomeConfiguration { host = "nix-pc"; };
        "gabriel@nix-notebook" = mkPerHostHomeConfiguration { host = "nix-notebook"; };
      };
      nixosConfigurations = {
        iso = mkSystemConfiguration { host = "iso"; };
        nix-pc = mkSystemConfiguration { host = "nix-pc"; };
        nix-notebook = mkSystemConfiguration { host = "nix-notebook"; };
      };
    };
}
