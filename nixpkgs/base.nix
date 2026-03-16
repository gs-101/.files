{
  fullName,
  lib,
  pkgs,
  system,
  username,
  ...
}:
{
  imports = [
    ./options/i18n.nix
    ./options/boot.nix
    ./options/networking.nix
    ./options/nix.nix
    ./options/services/guix.nix
    ./options/services/pipewire.nix
    ./options/services/xserver.nix
    ./options/virtualisation/podman.nix
  ];
  hardware.bluetooth.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault system;
  programs.dconf.enable = true;
  programs.nano.enable = false;
  programs.nix-ld.enable = true;
  security.rtkit.enable = true;
  services = {
    openssh.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;
    xserver.excludePackages = [ pkgs.xterm ];
  };
  users.users = {
    "${username}" = {
      description = fullName;
      extraGroups = [
        "networkmanager"
        "podman"
        "wheel"
      ];
      isNormalUser = true;
      initialPassword = "password";
    };
    root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC72pYuFq3Y8fNqHYmykdsK2cFoQV/5fChp4Fp89y9gsV1zmI55TElZx+RH4gRfLqHtTH+UxLpJUynCUEQ1uJnkhTmXeWo2+E9CexsI27q5Cs+B/iRMDm7QKdAGwHbg7rH3pb4yFcjThyKcfDHc+nsGded95EYwFwCJkRDXZOq4TtCK6YeQwjvU6PsPrB/Qffi0b7eAra+SvPgYZkvtFOphxiWiUrmx1EpDzB+WOGwRb7UhwxYYRucx7gIcpaRofbGqDsQXRqZUNqm+4XCYFNWu9q6h/B/5lDAAvVuSQjez1Kimw9erNRg5bY+UotRhbOZgE/ifHGRzUtMnkUGJv/B17v/TKFGqXSj0nxUx+fpOqDb6dMJrrKWMyGcikRHy1pFPsjGAQhAkTGzILiXORFOsurE/a/PzW3pbxgSp0WX5LicaoacfFev399kDqwpV9PAl7O2sTVEyH8aOCpiIjK3P79YCBW/Jpjd9yyouRU//ZzLYoACkhTsZ+M36C4sdDzx34ZlKcS9OBXJJo/z/LXRr46Ttmgh2xjYkzvIQVAa7uzlzkrDeE2k6npDXETk9H57qPSNbkUzktpMOYiBtQVvf6PBlR8ANdVKbgVVxbm5RnljkS8MY3ymF1K0iIeSQN+gklCx+GocylpIvDjxM3JJiWxfGQAQvOuFdYijrql9m7w== openpgp:0xAAFE1057"
    ];
  };
  virtualisation.containers.enable = true;
}
