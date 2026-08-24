{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      # TODO: remove IdentityFile after setting up host-specific keys.
      "git.gs-101.dev" = {
        hostname = "nix-server";
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
        user = "forgejo";
      };
      "nix-pc".IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
      "nix-server".IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
    };
  };
}
