return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		routes = {
			{
				view = "notify",
				filter = {
					event = "msg_showmode",
					any = {
						{ find = "recording" },
					},
				},
			},
			{
				filter = {
					event = "lsp",
					kind = "progress",
					any = {
						{ find = "pyright" },
					},
				},
				opts = { skip = true },
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
} -- Adds a floating command line
