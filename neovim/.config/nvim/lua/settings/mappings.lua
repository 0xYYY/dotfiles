local utils = require("utils")

-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Source/Edit init.lua
utils.map("n", "<Leader>sv", ":source ~/.config/nvim/init.lua<CR>", { silent = false })
utils.map("n", "<Leader>ev", ":tabnew ~/.config/nvim/init.lua<CR>")

-- Save/Close all buffers
utils.map("n", "<Leader>W", ":wall<CR>")
utils.map("n", "<Leader>X", ":xall<CR>")

-- Split window
utils.map("n", "<Leader>xs", ":vsplit<CR>")
utils.map("n", "<Leader>vs", ":split<CR>")

-- Close window
utils.map("n", "<leader>q", ":q<CR>")

-- Escape
utils.map("i", "jk", "<ESC>")
-- inoremap kj <ESC>

-- :->;
utils.map("n", ";", ":", { silent = false })

-- Move to start/end of line
utils.map("n", "H", "^")
utils.map("n", "L", "$")

-- Move to next/previous page and center
-- utils.map("n", "<C-f>", "<C-f>zz")
-- utils.map("n", "<C-b>", "<C-b>zz")

-- Move line up/down one line
utils.map("n", "-", "ddkP")
utils.map("n", "_", "ddp")

-- Copy and paste current line
utils.map("n", "pp", "Vyp")

-- Select previously selected text
utils.map("n", "<Leader>ss", "gv")

-- Select pasted text
utils.map("n", "<Leader>sp", "`[v`]")

-- Select innerword
utils.map("n", "<SPACE>", "viw")
utils.map("n", "<CR>", "ciw")

-- Delete current line in insert mode
-- utils.map("i", "<C-d>", "<ESC>ddi")

-- Undo in insert mode
-- utils.map("i", "<C-u>", "<ESC>ui")

-- Toggle upper/lower case of a word
-- utils.map("n", "<C-c>", "viw~")
-- utils.map("i", "<C-c>", "<ESC>viw~i")

-- Copy to/paste from system clipboard
utils.map("n", "<Leader>y", '"+y')
utils.map("v", "<Leader>y", '"+y')
utils.map("n", "<Leader>p", '"+p')
utils.map("v", "<Leader>p", '"+p')
