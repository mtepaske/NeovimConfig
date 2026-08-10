return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>ps", builtin.find_files)
	end,
} -- Telescope. Allows for searching for files and file navigaion
