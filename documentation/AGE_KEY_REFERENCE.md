# Age Key Quick Reference

## Your Age Keys

**Public Key (safe to share):**
```
age1y683tsrxyv9ywkl6jfvql2cnvzv54u0a8fl69yvgqlj4vgt4pfcqaw7auw
```

**Private Key Location:**
- File: `~/.config/sops/age/keys.txt`
- Backup: iCloud Keychain & Passwords app
- Entry name: "Nix Config Age Key (Passwords)"

## Retrieve Private Key from Backup

**From Passwords App:**
```
1. Open Passwords app
2. Search: "Nix Config Age Key"
3. Copy the password field
```

**From Command Line:**
```bash
security find-generic-password -a "jeanres" -s "Nix Config Age Key (Passwords)" -w
```

## Restore on New Machine

```bash
# 1. Clone your nix-config
git clone <your-repo> ~/.nix-config

# 2. Create age key directory
mkdir -p ~/.config/sops/age

# 3. Get key from Passwords app or run:
security find-generic-password -a "jeanres" -s "Nix Config Age Key (Passwords)" -w > ~/.config/sops/age/keys.txt

# 4. Set correct permissions
chmod 600 ~/.config/sops/age/keys.txt

# 5. Rebuild system
cd ~/.nix-config
sudo darwin-rebuild switch --flake ~/.nix-config
```

## Managing Secrets

**Edit encrypted secrets:**
```bash
cd ~/.nix-config
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

**Add new secret to configuration:**
1. Edit `secrets/secrets.yaml` to add the secret
2. Update `home/sops.nix` to define where it should be deployed
3. Rebuild: `sudo darwin-rebuild switch --flake ~/.nix-config`

**View decrypted secrets (for debugging):**
```bash
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt \
  nix-shell -p sops --run "sops --decrypt ~/.nix-config/secrets/secrets.yaml"
```

## Security Checklist

✅ Private age key backed up to Passwords app
✅ Private age key backed up to iCloud Keychain  
✅ Encrypted secrets committed to git
✅ Private age key NOT committed to git
✅ SSH key encrypted in secrets.yaml

## Emergency: Lost Age Key

If you lose your age key:
1. Check Passwords app
2. Check iCloud Keychain on other devices
3. If truly lost, you'll need to:
   - Generate new age key
   - Re-encrypt all secrets
   - Update .sops.yaml with new public key
