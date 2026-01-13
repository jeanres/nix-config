# Using sops-nix for SSH Key Management

This guide explains how to use sops-nix to securely store SSH keys and other secrets in your Nix configuration.

## Overview

sops-nix is integrated into your configuration at:
- **flake.nix**: Added sops-nix input
- **home/sops.nix**: Sops configuration module
- **.sops.yaml**: Sops encryption rules

## Initial Setup

### 1. Generate Your Age Key

First, generate an age key for encryption:

```bash
# Create the directory
mkdir -p ~/.config/sops/age

# Generate a new age key
nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"

# View your public key (needed for .sops.yaml)
age-keygen -y ~/.config/sops/age/keys.txt
```

**IMPORTANT**: Never commit `~/.config/sops/age/keys.txt` to git!

### 2. Update .sops.yaml

Edit `/Users/jeanres/.nix-config/.sops.yaml` and replace the age public key with yours:

```yaml
keys:
  - &admin_jeanres YOUR_AGE_PUBLIC_KEY_HERE

creation_rules:
  - path_regex: secrets/[^/]+\.yaml$
    key_groups:
      - age:
          - *admin_jeanres
```

### 3. Create Your First Secret File

Create an encrypted secrets file:

```bash
cd ~/.nix-config

# Create the secrets file (will open in your $EDITOR)
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

Add your secrets in YAML format:

```yaml
# Example: SSH private key
ssh_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  your_private_key_here
  -----END OPENSSH PRIVATE KEY-----

# Example: GitHub token
github_token: ghp_your_token_here
```

Save and exit. The file will be encrypted automatically.

## Using Secrets in Your Configuration

### Enable Secret Management

Edit `~/.nix-config/home/sops.nix` and uncomment/add your secrets:

```nix
sops = {
  age.keyFile = "${vars.homeDirectory}/.config/sops/age/keys.txt";
  defaultSopsFile = ../secrets/secrets.yaml;
  validateSopsFiles = true; # Enable after creating secrets.yaml
  
  secrets = {
    # SSH private key
    "ssh_key" = {
      path = "${vars.homeDirectory}/.ssh/id_ed25519";
      mode = "0600";
    };
    
    # GitHub token
    "github_token" = {
      path = "${vars.homeDirectory}/.config/github/token";
      mode = "0600";
    };
  };
};
```

### Rebuild Your System

```bash
cd ~/.nix-config
sudo darwin-rebuild switch --flake ~/.nix-config
```

After rebuild, your secrets will be decrypted and placed at the specified paths.

## Managing Secrets

### Edit Encrypted Secrets

```bash
cd ~/.nix-config
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

### Add New Secrets

1. Edit the encrypted file: `sops secrets/secrets.yaml`
2. Add the new secret key/value
3. Update `home/sops.nix` to reference the new secret
4. Rebuild: `darwin-rebuild switch --flake ~/.nix-config`

### Rotate Keys

If you need to change your age key:

```bash
# Generate new key
age-keygen -o ~/.config/sops/age/keys-new.txt

# Get new public key
age-keygen -y ~/.config/sops/age/keys-new.txt

# Update .sops.yaml with new public key
# Re-encrypt all secrets
cd ~/.nix-config
nix-shell -p sops --run "sops updatekeys secrets/secrets.yaml"

# Replace old key
mv ~/.config/sops/age/keys-new.txt ~/.config/sops/age/keys.txt
```

## Example: SSH Key Management

### Store Existing SSH Key

```bash
cd ~/.nix-config

# Create secrets file if not exists
nix-shell -p sops --run "sops secrets/secrets.yaml"

# Add your SSH key (paste the entire private key)
# Format:
# ssh_key: |
#   -----BEGIN OPENSSH PRIVATE KEY-----
#   [your key content]
#   -----END OPENSSH PRIVATE KEY-----
```

### Configure in home/sops.nix

```nix
sops = {
  secrets = {
    "ssh_key" = {
      path = "${vars.homeDirectory}/.ssh/id_ed25519";
      mode = "0600";
    };
    
    # For public key (optional, can be plain text)
    "ssh_key_pub" = {
      path = "${vars.homeDirectory}/.ssh/id_ed25519.pub";
      mode = "0644";
    };
  };
};
```

## Security Best Practices

1. **Never commit unencrypted secrets** to git
2. **Backup your age key** (`~/.config/sops/age/keys.txt`) securely
3. **Encrypted secrets CAN be committed** to git (they're safe)
4. **Use restrictive permissions** (0600 for private keys, 0644 for public)
5. **Rotate keys periodically** for security

## Troubleshooting

### "Failed to get data key"
- Ensure your age key exists at `~/.config/sops/age/keys.txt`
- Check that the public key in `.sops.yaml` matches your age key

### "No such file or directory"
- Make sure you've created `secrets/secrets.yaml`
- Run `sops secrets/secrets.yaml` to create it

### Secrets not deployed
- Check `sops.validateSopsFiles` is `true` in `home/sops.nix`
- Ensure the secret name in `sops.nix` matches the key in `secrets.yaml`
- Rebuild with `darwin-rebuild switch`

## What's Safe to Commit?

✅ **Safe to commit:**
- `.sops.yaml` (contains only public keys)
- `secrets/*.yaml` (encrypted files)
- `home/sops.nix` (configuration)

❌ **NEVER commit:**
- `~/.config/sops/age/keys.txt` (your private age key)
- Any unencrypted secrets

## Additional Resources

- [sops-nix documentation](https://github.com/Mic92/sops-nix)
- [age encryption tool](https://github.com/FiloSottile/age)
- [sops documentation](https://github.com/mozilla/sops)
