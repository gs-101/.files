{ config, ... }:
{
  programs.ssh = {
    enable = true;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      # TODO: remove these after setting up host-specific keys.
      "nix-pc".IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
      "nix-server" = {
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
        Port = 2200;
      };
    };
  };
}
