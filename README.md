# System Configuration

## Installation with `nixos-anywhere`

To provision a machine remotely over SSH using `nixos-anywhere`:

### 1. Retrieve Hardware Configuration

Boot the target system into a minimal Linux/NixOS environment with SSH access, then generate hardware settings without filesystem declarations:

```shell
nixos-generate-config --no-filesystems --show-hardware-config
```

Incorporate the generated hardware settings into `nixpkgs/<device>/default.nix`:
- `boot.initrd.availableKernelModules` and `boot.kernelModules`
- `hardware.cpu.<intel|amd>.updateMicrocode = true;`
- `nixpkgs.hostPlatform = "x86_64-linux";` (or target architecture)

### 2. Configure Disk Partitioning with Disko

In `nixpkgs/<device>/options/disko.nix`:
- Verify the target disk identifier matches the hardware (e.g., `/dev/nvme0n1` or `/dev/sda`).
- Define the partition scheme (e.g., GPT, ESP at `/boot`, LUKS encrypted container, Btrfs subvolumes, and swap).

Because each system imports Disko modules, `nixos-anywhere` automatically executes Disko during installation to partition, format, and mount the filesystems on the target machine.

### 3. Deploy with `nixos-anywhere`

From the deployment machine:

1. If LUKS encryption is used, store the passphrase in `/tmp/secret.key`:
   ```shell
   echo -n "password" > /tmp/secret.key
   ```

2. Run `nixos-anywhere` to partition disks via Disko and install NixOS:
   ```shell
   nix run github:nix-community/nixos-anywhere -- \
     --disk-encryption-keys /tmp/secret.key /tmp/secret.key \
     --flake .#<device> \
     root@<target-ip>
   ```

*(Omit `--disk-encryption-keys` if disk encryption is not configured or if passphrases are entered interactively).*

## After declaring a system (Manual Installation)

1. LUKS password in `/tmp/secret.key` or interactive
2. Add live ISO's SSH key to SOPS

```shell
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

3. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko --flake .#device`
4. Copy live ISO's SSH keys to the mount partition
5. `sudo nixos-install --flake .#device`

### TPM 2.0 Auto-Unlock (Desktops / Laptops)

For machines with a TPM 2.0 chip (like `nix-pc` and `nix-notebook`), enroll the TPM so LUKS automatically decrypts on boot without manual password entry:

```shell
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7 /dev/nvme0n1p2
```

*(Replace `/dev/nvme0n1p2` with the path to the encrypted partition if different).*

### Remote LUKS Unlock (Headless Servers)

For headless machines without TPM 2.0 (like `nix-server`), early-boot SSH in stage-1 initramfs is used.

1. Generate an `initrd` SSH host key (without a passphrase):

```shell
ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_initrd_ed25519_key
```

2. To unlock the server remotely from another machine on the LAN (e.g., via `nix-pc` over Tailscale):

```shell
ssh root@<server-lan-ip>
```

3. Once connected to the early-boot environment, run the password agent to enter the LUKS passphrase:

```shell
systemd-tty-ask-password-agent
```
