return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("ruff", {
				init_options = {
					settings = {
						fixAll = true,
						organizeImports = true,
					},
				},
			})

			vim.lsp.enable("ruff")
		end,
	},
}
