{
  virtualisation.oci-containers.containers."any2nix" = {
    image = "ghcr.io/gbr-ufs/any2nix-website:0.1.6";
    ports = [
      "3003:3000"
    ];
  };
}
