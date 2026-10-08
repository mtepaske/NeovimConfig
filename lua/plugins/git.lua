return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, {
						buffer = bufnr,
						desc = desc,
					})
				end
				map("n", "]c", function()
					gs.nav_hunk("next")
				end, "Next Git hunk")
				map("n", "[c", function()
					gs.nav_hunk("prev")
				end, "Previous Git hunk")
				map("n", "<leader>hs", gs.stage_hunk, "Stage Git hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Git hunk")
				map("n", "<leader>hp", gs.preview_hunk, "Preview Git hunk")
				map("n", "<leader>hd", gs.diffthis, "View Diff")
			end,
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
} -- Adds GIT integration
