{...}:
{
	programs.lazygit = {
		enable = true;
	};
	programs.git = {
		enable = true;
		userEmail = "jeanres@icloud.com";
		userName = "Jeanre Swanepoel";
		aliases = {
			co = "checkout";
			ci = "commit";
			di = "diff";
			dc = "diff --cached";
			fa = "fetch --all";
			pf = "push --force-with-lease";
			cl = "clone";
			amend = "commit --amend";
		};
		extraConfig = {
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
					insteadOf = [ "github:" "gh:" "git://github.com/" ];
				};
			};
			# Global git hooks with OpenCode integration
			core = {
				hooksPath = "~/.config/git/hooks";
			};
		};
	};

	# Install git hooks globally
	home.file.".config/git/hooks/pre-commit" = {
		source = ./git-hooks/pre-commit;
		executable = true;
	};
	home.file.".config/git/hooks/commit-msg" = {
		source = ./git-hooks/commit-msg;
		executable = true;
	};
	home.file.".config/git/hooks/pre-push" = {
		source = ./git-hooks/pre-push;
		executable = true;
	};
}
