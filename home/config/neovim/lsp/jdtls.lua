return {
	cmd = { "jdtls", "--jvm-arg=-javaagent:" .. vim.fn.glob("/nix/store/*lombok*/share/java/lombok.jar") },
	filetypes = { "java" },
	root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", "mvnw", "gradlew", ".git" },
	settings = {
		java = {
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
				},
			},
			codeGeneration = {
				toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
				useBlocks = true,
			},
		},
	},
}
