return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			filesystem = {
				filtered_items = {
					always_show_by_pattern = {
						"*.csv",
					},
				},
			},
		})
		vim.keymap.set("n", "\\", ":Neotree toggle filesystem reveal left<CR>")
		vim.keymap.set("n", "<leader>b", ":Neotree toggle show buffers left<CR>")
		vim.keymap.set("n", "<leader>gs", ":Neotree float git status<CR>")
	end,
} -- NeoTree is a file explorer page within Neovim
