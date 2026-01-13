{ ... }:
{
  programs.lazygit = {
    enable = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "jeanres@icloud.com";
        name = "Jeanre Swanepoel";
      };
      alias = {
        co = "checkout";
        ci = "commit";
        di = "diff";
        dc = "diff --cached";
        fa = "fetch --all";
        pf = "push --force-with-lease";
        cl = "clone";
        amend = "commit --amend";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        ff = "only";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      commit = {
        verbose = true;
      };
      diff = {
        tool = "vimdiff";
      };
      url = {
        "ssh://git@github.com/" = {
          insteadOf = [
            "github:"
            "gh:"
            "git://github.com/"
          ];
        };
      };
    };
  };
}
