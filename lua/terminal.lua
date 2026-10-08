local terminal = nil
vim.keymap.set("n", "<leader>t", function()
	if terminal and vim.api.nvim_buf_is_valid(terminal) then
		local win = vim.fn.bufwinid(terminal)
		if win == -1 then
			vim.cmd("botright 12split")
			vim.api.nvim_win_set_buf(0, terminal)
		else
			vim.api.nvim_win_hide(win)
		end
	else
		vim.cmd("botright 12split")
		vim.cmd("terminal")
		terminal = vim.api.nvim_get_current_buf()
	end
end)

local python_terminal = nil
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set("n", "<leader>r", function()
			local file = vim.fn.shellescape(vim.fn.expand("%:p"))
			if not (python_terminal and vim.api.nvim_buf_is_valid(python_terminal)) then
				vim.cmd("botright 12split")
				vim.cmd("terminal")
				python_terminal = vim.api.nvim_get_current_buf()
			else
				local win = vim.fn.bufwinid(python_terminal)
				if win == -1 then
					vim.cmd("botright 12split")
					vim.api.nvim_win_set_buf(0, python_terminal)
				else
					vim.api.nvim_set_current_win(win)
				end
			end
			vim.fn.chansend(vim.bo[python_terminal].channel, "python3 " .. file .. "\n")
		end, { buffer = true })
	end,
})
