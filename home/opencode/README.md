# OpenCode Configuration

TDD-focused OpenCode setup using GitHub Copilot Pro for C#, Ruby, and Java development.

## Structure

```
home/opencode/
├── opencode.json          # Main configuration
└── agent/                 # Specialized agents
    ├── plan.md           # Planning agent (TDD-focused)
    ├── test.md           # Test-writing agent
    ├── build.md          # Implementation agent
    ├── review.md         # Code review agent
    ├── security.md       # Security audit agent
    ├── debug.md          # Debugging agent
    ├── docs.md           # Documentation agent
    └── refactor.md       # Refactoring agent
```

## Models

- **Primary**: `github/claude-sonnet-4.5` - Best for C#/Ruby/Java coding
- **Small**: `github/gpt-5-mini` - Fast, unlimited for planning/reviews

## Custom Commands

### TDD Workflow
- `/tdd <feature>` - Full TDD cycle: plan → test → implement → review → security
- `/plan <feature>` - Create detailed implementation plan
- `/test <feature>` - Write tests FIRST (Red phase)
- `/implement` - Implement to pass tests (Green phase)
- `/refactor <what>` - Safe refactoring with test coverage

### Code Quality
- `/review` - Comprehensive code review
- `/security` - Security audit
- `/docs <what>` - Generate/update documentation

### Debugging
- `/fix` - Debug and fix failing tests

## Setup

1. **Sign up for GitHub Copilot Pro** ($10/month)
   - Visit: https://github.com/github-copilot/pro
   - Start 30-day free trial

2. **Authenticate with OpenCode**
   ```bash
   opencode auth login
   # Select "GitHub Copilot"
   # Follow device code flow
   ```

3. **Rebuild Nix configuration**
   ```bash
   home-manager switch
   ```

4. **Verify setup**
   ```bash
   opencode
   /models  # Should show GitHub Copilot models
   ```

## Agent Descriptions

### Plan Agent (gpt-5-mini)
- Read-only, no modifications
- Creates TDD-focused implementation plans
- Designs test strategy before implementation
- Temperature: 0.1 (precise)

### Test Agent (claude-sonnet-4.5)
- Writes tests FIRST (TDD Red phase)
- Supports xUnit, RSpec, JUnit
- Follows AAA pattern
- Temperature: 0.2 (focused)

### Build Agent (claude-sonnet-4.5)
- Implements to pass tests (TDD Green phase)
- Follows SOLID principles
- Language-specific best practices
- Temperature: 0.3 (creative)

### Review Agent (gpt-5-mini)
- Read-only code review
- Checks quality, bugs, performance, security
- Language-specific best practices
- Temperature: 0.1 (critical)

### Security Agent (gpt-5-mini)
- Read-only security audit
- OWASP Top 10 focus
- Dependency vulnerability checks
- Temperature: 0.1 (thorough)

### Debug Agent (claude-sonnet-4.5)
- Investigates test failures
- Root cause analysis
- Can run diagnostic commands
- Temperature: 0.2 (analytical)

### Docs Agent (gpt-5-mini)
- Generates documentation
- API docs, READMEs, guides
- Code examples
- Temperature: 0.3 (descriptive)

### Refactor Agent (claude-sonnet-4.5)
- Safe refactoring with tests
- Keeps tests green throughout
- Removes code smells
- Temperature: 0.2 (careful)

## Permissions

### Main Agent
- **Edit**: Ask (review diffs before applying)
- **Bash**: Allow safe commands (tests, git status)
- **Bash**: Ask for risky commands (installs, deletions)

### Safe Commands (Auto-allowed)
- `git status`, `git diff`, `git log`, `git branch`
- `dotnet test`, `dotnet build`, `dotnet run`
- `bundle exec rspec`, `bundle exec rubocop`, `bundle install`
- `mvn test`, `mvn compile`
- `gradle test`, `gradle build`
- `npm test`, `yarn test`

## TDD Workflow Example

```bash
# 1. Plan the feature
/tdd Add user authentication with JWT

# 2. Agent creates plan with test strategy
# Review and approve plan

# 3. Write tests first (Red)
/test User authentication with JWT

# 4. Run tests - they should fail
# Verify tests fail for the right reason

# 5. Implement to pass tests (Green)
/implement

# 6. Run tests - they should pass
# All tests green!

# 7. Review the code
/review

# 8. Security audit
/security

# 9. Refactor if needed (keeping tests green)
/refactor Extract JWT logic into service
```

## Cost Estimate

With GitHub Copilot Pro:
- **Fixed cost**: $10/month
- **Unlimited**: gpt-5-mini usage (planning, reviews)
- **300 premium requests/month**: claude-sonnet-4.5 (coding)
- **No surprise bills**

Typical professional usage: Well within limits

## Tips

1. **Always start with `/plan`** - Think before coding
2. **Write tests first** - Use `/test` before `/implement`
3. **Keep tests green** - Run tests frequently
4. **Review before commit** - Use `/review` and `/security`
5. **Refactor safely** - Use `/refactor` with test coverage
6. **Use Tab key** - Switch between Plan and Build modes

## Troubleshooting

### Models not showing up
```bash
opencode auth login
# Re-authenticate with GitHub Copilot
```

### Agent not found
```bash
home-manager switch
# Rebuild Nix configuration
```

### Tests not running
Check bash permissions in `opencode.json` - test commands should be allowed.

## References

- [OpenCode Docs](https://opencode.ai/docs)
- [GitHub Copilot Plans](https://github.com/features/copilot/plans)
- [TDD Best Practices](https://martinfowler.com/bliki/TestDrivenDevelopment.html)
