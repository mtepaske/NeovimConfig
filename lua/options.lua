vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- Makes indents 4 spaces large

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Sets space as leader key

vim.opt.nu = true
vim.opt.relativenumber = true
-- Enables relative line numbers

vim.opt.splitright = true
vim.opt.splitbelow = true
-- Default split is now below and to the right

vim.optignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3
-- Smart case for searching

vim.opt.cursorline = true
-- Highlights current line

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- Keeps curser above the bottom of screen when scrolling

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.hl.on_yank()
	end,
})
-- Highlights when yanking

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
-- Enables folding for expressions

vim.keymap.set("n", "\\", ":Neotree toggle filesystem reveal left<CR>")
vim.keymap.set("n", "<leader>b", ":Neotree toggle show buffers left<CR>")
vim.keymap.set("n", "<leader>gs", ":Neotree float git status<CR>")
-- Neotree keymappings

vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clears search highlighting" })
-- Removes highlighting from search

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down " })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down " })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line without moving curser" })
-- Line joining and line moving keymaps

vim.keymap.set("n", "<leader>hm", ':lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set("n", "<leader>hl", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set("n", "<leader>hn", ':lua require("harpoon.ui").nav_next()<CR>')
vim.keymap.set("n", "<leader>hp", ':lua require("harpoon.ui").nav_prev()<CR>')
-- Harpoon Keymappings

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Page jumping and seaarch jumping keymaps

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
-- Better copy and paste keymaps

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Keymappings from the Primagen

vim.keymap.set("n", "<Leader>nf", ":lua require('neogen').generate()<CR>")
-- Generate docstring

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set("n", "<leader>r", ":!python3 %<CR>", { buffer = true })
	end,
})
-- Run python code in nvim

vim.opt.mouse = ""
vim.opt.mousescroll = "ver:0,hor:0"
-- Change mouse settings
