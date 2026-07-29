{
  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      ssh_aur_key = {
        path = "/home/gabriel/.ssh/id_ed25519_aur";
        mode = "0400";
        owner = "gabriel";
      };
      ssh_educational_key = {
        path = "/home/gabriel/.ssh/id_ed25519_educational";
        mode = "0400";
        owner = "gabriel";
      };
      ssh_personal_key = {
        path = "/home/gabriel/.ssh/id_ed25519_personal";
        mode = "0400";
        owner = "gabriel";
      };
    };
  };
}
