# System Configuration

## After declaring a system

1. LUKS password in `/tmp/secret.key` or interactive
2. Add live ISO's SSH key to SOPS

```shell
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

3. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko --flake .#device`
4. Copy live ISO's SSH keys to the mount partition
5. `sudo nixos-install --flake .#device`

### Servers

1. Generate an `initrd` SSH key

```shell
ssh-keygen -t ed25519 -f /etc/ssh/initrd_host_ed25519_key
```
