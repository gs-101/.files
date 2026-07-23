# TODO: Expose this publicly.

{ host, ... }:
let
  httpAddr = "localhost:10000";
  sshAddr = 2222;
in
{
  networking.firewall.allowedTCPPorts = [ sshAddr ];
  services = {
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          redir /soft-serve /soft-serve/
          handle_path /soft-serve/* {
            reverse_proxy ${httpAddr}
          }
        '';
      };
    };
    soft-serve = {
      enable = true;
      settings = {
        http = {
          listen_addr = httpAddr;
          public_url = "https://${host}.tailbf3a7f.ts.net/soft-serve/";
        };
        initial_admin_keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO"
        ];
        name = "gs-101";
        ssh = {
          listen_addr = ":${toString sshAddr}";
          public_url = "ssh://${host}.tailbf3a7f.ts.net:${toString sshAddr}";
        };
      };
    };
  };
}
