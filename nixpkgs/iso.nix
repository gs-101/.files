{
  modulesPath,
  pkgs,
  system,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  environment.systemPackages = with pkgs; [
    disko
  ];
  isoImage.forceTextMode = true;
  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  nixpkgs.hostPlatform = system;
  programs = {
    nano.enable = false;
  };
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC72pYuFq3Y8fNqHYmykdsK2cFoQV/5fChp4Fp89y9gsV1zmI55TElZx+RH4gRfLqHtTH+UxLpJUynCUEQ1uJnkhTmXeWo2+E9CexsI27q5Cs+B/iRMDm7QKdAGwHbg7rH3pb4yFcjThyKcfDHc+nsGded95EYwFwCJkRDXZOq4TtCK6YeQwjvU6PsPrB/Qffi0b7eAra+SvPgYZkvtFOphxiWiUrmx1EpDzB+WOGwRb7UhwxYYRucx7gIcpaRofbGqDsQXRqZUNqm+4XCYFNWu9q6h/B/5lDAAvVuSQjez1Kimw9erNRg5bY+UotRhbOZgE/ifHGRzUtMnkUGJv/B17v/TKFGqXSj0nxUx+fpOqDb6dMJrrKWMyGcikRHy1pFPsjGAQhAkTGzILiXORFOsurE/a/PzW3pbxgSp0WX5LicaoacfFev399kDqwpV9PAl7O2sTVEyH8aOCpiIjK3P79YCBW/Jpjd9yyouRU//ZzLYoACkhTsZ+M36C4sdDzx34ZlKcS9OBXJJo/z/LXRr46Ttmgh2xjYkzvIQVAa7uzlzkrDeE2k6npDXETk9H57qPSNbkUzktpMOYiBtQVvf6PBlR8ANdVKbgVVxbm5RnljkS8MY3ymF1K0iIeSQN+gklCx+GocylpIvDjxM3JJiWxfGQAQvOuFdYijrql9m7w== openpgp:0xAAFE1057"
  ];
}
