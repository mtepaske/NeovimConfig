return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"javascript",
			"python",
			"markdown",
			"r",
			"csv",
			"markdown_inline",
			"latex",
			"rnoweb",
			"typst",
			"yaml",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"javascript",
				"python",
				"markdown",
				"r",
				"csv",
				"markdown_inline",
				"latex",
				"rnoweb",
				"typst",
				"yaml",
			},
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
} -- Adds syntax highlighting and language manager
