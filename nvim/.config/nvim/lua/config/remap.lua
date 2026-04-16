vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move Selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Fix cursor position for defaults
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep yank after paste
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Quick bind for yanking to global buffer
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Unbind Q
vim.keymap.set("n", "Q", "<nop>")

-- Make Ctrl+C = Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Live server binds
vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>")
vim.keymap.set("n", "<leader>lx", ":LiveServerStop<CR>")
