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
		};
	};
}
