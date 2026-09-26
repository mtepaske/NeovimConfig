return {
	"stevearc/conform.nvim",

	opts = {
		formatters_by_ft = {
			python = { "ruff_fix", "black" },

			lua = { "stylua" },

			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },

			r = { "styler" },
		},

		formatters = {
			stylua = {
				prepend_args = {
					"--indent-width",
					"4",
				},
			},
			prettier = {
				prepend_args = {
					"--tab-width",
					"4",
				},
			},
		},

		format_on_save = {
			timeout_ms = 5000,
			lsp_fallback = true,
		},
	},
}
