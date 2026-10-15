local python_terminal = nil
local normal_terminal = nil
local last_python_file = nil

-- Check whether a terminal buffer exists and its process is running.
local function valid_terminal(buf)
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		return false
	end

	if vim.bo[buf].buftype ~= "terminal" then
		return false
	end

	local channel = vim.bo[buf].channel
	return channel > 0 and vim.fn.jobwait({ channel }, 0)[1] == -1
end

-- Show or hide an existing terminal, creating one only if necessary.
local function toggle_terminal(buf)
	if valid_terminal(buf) then
		local win = vim.fn.bufwinid(buf)

		if win ~= -1 then
			vim.api.nvim_win_hide(win)
		else
			vim.cmd("botright 12split")
			vim.api.nvim_win_set_buf(0, buf)
		end

		return buf
	end

	vim.cmd("botright 12split")
	vim.cmd("terminal")
	return vim.api.nvim_get_current_buf()
end

-- Remember the most recently visited Python file.
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	callback = function()
		if vim.bo.filetype == "python" then
			last_python_file = vim.api.nvim_buf_get_name(0)
		end
	end,
})

-- Run the last Python file, even when the terminal has focus.
vim.keymap.set("n", "<leader>r", function()
	if vim.bo.filetype == "python" then
		last_python_file = vim.api.nvim_buf_get_name(0)
	end

	if not last_python_file or last_python_file == "" then
		vim.notify("No Python file to run", vim.log.levels.WARN)
		return
	end

	if not valid_terminal(python_terminal) then
		python_terminal = toggle_terminal(nil)
	else
		local win = vim.fn.bufwinid(python_terminal)

		if win == -1 then
			vim.cmd("botright 12split")
			vim.api.nvim_win_set_buf(0, python_terminal)
		else
			vim.api.nvim_set_current_win(win)
		end
	end

	local file = vim.fn.shellescape(last_python_file)
	vim.fn.chansend(vim.bo[python_terminal].channel, "python3 " .. file .. "\n")
end, { desc = "Run Python file" })

-- Toggle the relevant terminal.
vim.keymap.set("n", "<leader>t", function()
	local current_buf = vim.api.nvim_get_current_buf()

	-- If we're in the Python terminal or a Python file,
	-- toggle the Python terminal.
	if
		valid_terminal(python_terminal)
		and (current_buf == python_terminal or vim.bo[current_buf].filetype == "python")
	then
		python_terminal = toggle_terminal(python_terminal)
	else
		normal_terminal = toggle_terminal(normal_terminal)
	end
end, { desc = "Toggle terminal" })

-- Escape terminal mode with Esc.
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Terminal buffers are not files, so don't try to save them.
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.bo.modified = false
	end,
})

-- Stop terminal jobs when quitting Neovim.
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
				local channel = vim.bo[buf].channel

				if channel > 0 and vim.fn.jobwait({ channel }, 0)[1] == -1 then
					vim.fn.jobstop(channel)
					vim.fn.jobwait({ channel }, 1000)
				end

				vim.bo[buf].modified = false
			end
		end
	end,
})

--[[
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

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>\]\])

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
]]
