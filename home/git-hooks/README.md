# Git Hooks with OpenCode Integration

Automated git hooks that use OpenCode agents to maintain code quality.

## Hooks Included

### 🔒 pre-commit
Runs before each commit to catch issues early.

**Checks:**
- **Security Audit**: Uses OpenCode `/security` agent to detect vulnerabilities
- **Code Review**: Uses OpenCode `/review` agent to check code quality
- Analyzes only staged files
- Fails on critical security issues
- Warns on code quality issues

**Usage:**
```bash
git commit -m "Add feature"
# Hooks run automatically

# Skip if needed (not recommended)
git commit --no-verify -m "Add feature"
```

### 📝 commit-msg
Validates commit message quality.

**Checks:**
- Minimum message length (10 characters)
- Detects placeholder messages (wip, todo, etc.)
- Warns about long first lines (>72 chars)
- Suggests imperative mood

**Examples:**
```bash
# ✅ Good
git commit -m "Add user authentication with JWT"

# ❌ Bad
git commit -m "wip"
git commit -m "fix"
```

### 🚀 pre-push
Runs tests before pushing to remote.

**Checks:**
- Auto-detects project type (.NET, Ruby, Java, Node.js)
- Runs appropriate test suite
- Prevents pushing broken code

**Supported:**
- .NET: `dotnet test`
- Ruby/Rails: `bundle exec rspec` or `rails test`
- Java/Maven: `mvn test`
- Java/Gradle: `gradle test`
- Node.js: `npm test`

**Usage:**
```bash
git push origin main
# Tests run automatically

# Skip if needed (not recommended)
git push --no-verify origin main
```

## Installation

### Automatic (via Nix)
Hooks are automatically installed when you rebuild your Nix configuration:

```bash
darwin-rebuild switch --flake ~/.nix-config
# or
home-manager switch
```

### Manual Installation
For non-Nix projects:

```bash
# Copy hooks to your project
cp ~/.nix-config/home/git-hooks/* /path/to/project/.git/hooks/

# Make them executable
chmod +x /path/to/project/.git/hooks/*
```

### Global Git Hooks (All Projects)
Set up hooks for all your git repositories:

```bash
# Configure global hooks directory
git config --global core.hooksPath ~/.config/git/hooks

# Copy hooks there
mkdir -p ~/.config/git/hooks
cp ~/.nix-config/home/git-hooks/* ~/.config/git/hooks/
chmod +x ~/.config/git/hooks/*
```

## Configuration

### Disable Specific Hooks
Create `.git/hooks/skip-hooks` in your project:

```bash
# Skip all OpenCode checks
SKIP_OPENCODE=1

# Skip only security checks
SKIP_SECURITY=1

# Skip only review checks
SKIP_REVIEW=1

# Skip test runs
SKIP_TESTS=1
```

### Adjust Timeouts
Edit the hook files to change timeout values:

```bash
# In pre-commit hook
timeout 30s  # Change to 60s for slower checks
```

### Custom Security Rules
Add project-specific security rules in `.opencode/rules.md`:

```markdown
# Security Rules
- Never commit API keys or secrets
- Always validate user input
- Use parameterized queries for SQL
```

## Troubleshooting

### Hooks Not Running
```bash
# Check if hooks are executable
ls -la .git/hooks/

# Make them executable
chmod +x .git/hooks/*

# Verify git hooks path
git config core.hooksPath
```

### OpenCode Not Found
```bash
# Check if opencode is in PATH
which opencode

# If not, add to PATH or use full path in hooks
/full/path/to/opencode
```

### Hooks Too Slow
```bash
# Reduce timeout in hooks
# Edit pre-commit and change:
timeout 30s  # to 15s

# Or skip OpenCode checks for quick commits
git commit --no-verify
```

### False Positives
```bash
# Skip specific commit
git commit --no-verify

# Or adjust agent sensitivity in opencode.json
{
  "agent": {
    "security": {
      "temperature": 0.2  // Higher = less strict
    }
  }
}
```

## Best Practices

1. **Don't Skip Hooks Habitually**
   - Hooks are there to help you
   - Fix issues rather than bypassing checks

2. **Keep Hooks Fast**
   - Hooks should complete in <30 seconds
   - Use timeouts to prevent hanging

3. **Review Hook Output**
   - Read what the hooks tell you
   - Learn from the feedback

4. **Customize for Your Team**
   - Adjust checks based on your workflow
   - Add project-specific rules

5. **Test Hooks Locally**
   - Run hooks manually before committing:
   ```bash
   .git/hooks/pre-commit
   .git/hooks/pre-push
   ```

## Examples

### Successful Commit
```bash
$ git commit -m "Add JWT authentication"
🔍 Running pre-commit checks with OpenCode...
📝 Staged files:
  - src/auth/jwt.cs
  - tests/auth/jwt_tests.cs

🔒 Running security audit...
✓ No critical security issues detected

👀 Running code review...
✓ Code review passed

✅ All pre-commit checks passed!
✓ Commit message looks good
[main abc1234] Add JWT authentication
```

### Failed Security Check
```bash
$ git commit -m "Add API endpoint"
🔍 Running pre-commit checks with OpenCode...
🔒 Running security audit...
❌ Security issues found!
Review the following:
  - CRITICAL: SQL injection vulnerability in user_controller.rb:45
  - HIGH: Missing input validation in api/users.cs:123

❌ Pre-commit checks failed!
Fix the issues above or use 'git commit --no-verify' to skip checks.
```

### Skipping Hooks
```bash
# When you really need to skip (use sparingly!)
$ git commit --no-verify -m "WIP: debugging"
[main def5678] WIP: debugging

# Better: Fix the issues first
$ git commit -m "Fix SQL injection in user controller"
✅ All pre-commit checks passed!
```

## Integration with CI/CD

These hooks complement (not replace) CI/CD checks:

**Local Hooks (Fast Feedback):**
- Run on developer machine
- Catch obvious issues quickly
- Provide immediate feedback

**CI/CD (Comprehensive):**
- Run full test suite
- Check multiple environments
- Deploy to staging/production

Both are important for code quality!

## Cost Considerations

**GitHub Copilot Pro:**
- Hooks use your premium request quota
- Each security/review check = 1-2 requests
- 300 requests/month should be sufficient
- Monitor usage if committing frequently

**Tips to Reduce Usage:**
- Only run on staged files (already configured)
- Use timeouts to prevent long-running checks
- Skip hooks for trivial commits (--no-verify)
- Consider running only on pre-push for large teams

## Feedback

These hooks are part of your Nix configuration. To modify:

1. Edit files in `~/.nix-config/home/git-hooks/`
2. Rebuild: `darwin-rebuild switch`
3. Hooks automatically update in all projects using global hooks

Enjoy safer, higher-quality commits! 🎉
