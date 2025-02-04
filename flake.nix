{
  inputs = {
    disko.url = "github:nix-community/disko/latest";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia-qs.url = "github:noctalia-dev/noctalia-qs";
    nur.url = "github:nix-community/NUR";
  };
  outputs =
    {
      disko,
      emacs-overlay,
      home-manager,
      niri,
      noctalia,
      noctalia-qs,
      nixpkgs,
      ...
    }@inputs:
    {
      homeConfigurations = {
        "gabriel@nix-pc" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            niri.homeModules.niri
            noctalia.homeModules.default
            ./home-manager/nix-pc.nix
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
        "gabriel@nix-notebook" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            niri.homeModules.niri
            noctalia.homeModules.default
            ./home-manager/nix-notebook.nix
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
      nixosConfigurations = {
        nix-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./nixpkgs/nix-pc.nix
          ];
        };
        nix-notebook = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./nixpkgs/nix-notebook.nix
          ];
        };
      };
    };
}
