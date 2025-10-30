{ pkgs, ... }:

{
  # Main OpenCode configuration
  home.file.".config/opencode/opencode.json".source = ./opencode/opencode.json;

  # TDD-focused agents
  home.file.".config/opencode/agent/plan.md".source = ./opencode/agent/plan.md;
  home.file.".config/opencode/agent/test.md".source = ./opencode/agent/test.md;
  home.file.".config/opencode/agent/build.md".source = ./opencode/agent/build.md;
  home.file.".config/opencode/agent/review.md".source = ./opencode/agent/review.md;
  home.file.".config/opencode/agent/security.md".source = ./opencode/agent/security.md;

  home.file.".config/opencode/agent/debug.md".source = ./opencode/agent/debug.md;
  home.file.".config/opencode/agent/docs.md".source = ./opencode/agent/docs.md;
  home.file.".config/opencode/agent/refactor.md".source = ./opencode/agent/refactor.md;
}