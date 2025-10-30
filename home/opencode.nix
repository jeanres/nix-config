{ pkgs, ... }:

{
  home.file.".config/opencode/opencode.json".text = ''
    {
      "$schema": "https://opencode.ai/config.json",
"model": "github/copilot",
  "small_model": "github/copilot",
      "theme": "opencode",
      "autoupdate": true,
      "permission": {
        "edit": "ask",
        "bash": "ask"
      },
      "agent": {
        "plan": {
          "mode": "primary",
          "model": "github/copilot",
          "temperature": 0.1,
          "permission": {
            "edit": "deny",
            "bash": "deny",
            "write": "deny"
          },
          "tools": {
            "write": false,
            "edit": false,
            "bash": false
          }
        },
        "build": {
          "mode": "primary",
          "model": "github/copilot",
          "temperature": 0.3,
          "permission": {
            "edit": "allow",
            "bash": "allow",
            "write": "allow"
          }
        }
      },
      "command": {
        "test": {
          "template": "Run the full test suite with coverage report and show any failures.\\nFocus on the failing tests and suggest fixes.",
          "description": "Run tests with coverage",
          "agent": "build"
        },
        "review": {
          "template": "@review Review the current changes for best practices, security, and performance issues.",
          "description": "Code review",
          "agent": "build"
        },
        "plan": {
          "template": "@plan Create a detailed plan for implementing: $ARGUMENTS",
          "description": "Create implementation plan",
          "agent": "plan"
        }
      }
    }
  '';

  home.file.".config/opencode/agent/review.md".text = ''
---
description: Reviews code for best practices and potential issues
mode: subagent
model: github/copilot
temperature: 0.1
tools:
  write: false
  edit: false
  bash: false
---
You are a senior code reviewer. Focus on:
- Code quality and best practices
- Potential bugs and edge cases
- Performance implications
- Security considerations
- Code maintainability and readability
- Adherence to project conventions

Provide constructive feedback with specific suggestions for improvement.
  '';

  home.file.".config/opencode/agent/debug.md".text = ''
---
description: Investigates issues and debugging problems
mode: subagent
model: github/copilot
temperature: 0.2
tools:
  write: false
  edit: false
  bash: true
permission:
  bash:
    "git *": allow
    "ls": allow
    "cat": allow
    "grep": allow
    "find": allow
    "ps": allow
    "kill": allow
    "*": ask
---
You are a debugging expert. Focus on:
- Identifying root causes of issues
- Analyzing error messages and logs
- Tracing execution flow
- Checking system state and dependencies
- Suggesting debugging strategies

Use bash commands to investigate but never modify files directly.
  '';

  home.file.".config/opencode/agent/docs.md".text = ''
---
description: Writes and maintains project documentation
mode: subagent
model: github/copilot
temperature: 0.3
tools:
  bash: false
---
You are a technical writer. Create clear, comprehensive documentation.
Focus on:
- Clear explanations and proper structure
- Code examples and usage patterns
- User-friendly language
- Consistent formatting
- Updating existing documentation

Always ensure documentation is accurate and up-to-date.
  '';

  home.file.".config/opencode/agent/security.md".text = ''
---
description: Performs security audits and identifies vulnerabilities
mode: subagent
model: github/copilot
temperature: 0.1
tools:
  write: false
  edit: false
  bash: false
---
You are a security expert. Focus on identifying potential security issues.
Look for:
- Input validation vulnerabilities
- Authentication and authorization flaws
- Data exposure risks
- Dependency vulnerabilities
- Configuration security issues
- Sensitive data handling
- Injection vulnerabilities

Provide detailed security recommendations and risk assessments.
  '';

  home.file.".config/opencode/agent/performance.md".text = ''
---
description: Optimizes code for performance and efficiency
mode: subagent
model: github/copilot
temperature: 0.2
tools:
  write: false
  edit: false
  bash: true
permission:
  bash:
    "time": allow
    "hyperfine": allow
    "profiler": allow
    "*": ask
---
You are a performance optimization expert. Focus on:
- Identifying performance bottlenecks
- Algorithm efficiency analysis
- Memory usage optimization
- Database query optimization
- Network request optimization
- Caching strategies

Suggest specific optimizations with measurable improvements.
  '';
}