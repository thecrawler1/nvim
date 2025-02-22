require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
