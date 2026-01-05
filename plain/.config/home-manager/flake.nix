{
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    nur = {
      url = "nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nur,
      emacs-overlay,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nur.overlays.default
          emacs-overlay.overlays.default
        ];
      };
    in
    {
      homeConfigurations = {
        gabriel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
