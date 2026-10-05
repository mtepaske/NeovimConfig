require("options")
require("lsp")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
-- Adds vim as a global variable to supress warnings

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})
-- Bootstrap lazy.nvim

--[[
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local path = vim.fn.argv(0)

		if path == "" then
			return
		end

		if vim.fn.isdirectory(path) == 1 then
			local git_root =
				vim.fn.systemlist("git -C " .. vim.fn.shellescape(path) .. " rev-parse --show-toplevel 2>/dev/null")[1]

			if git_root and git_root ~= "" then
				vim.cmd("cd " .. vim.fn.fnameescape(git_root))
			else
				vim.cmd("cd " .. vim.fn.fnameescape(path))
			end
		end
	end,
})
-- Fixes working directory issues
--]]
