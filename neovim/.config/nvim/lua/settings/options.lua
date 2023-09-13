local opt = vim.opt
local cmd = vim.cmd

-- Program host
vim.g.python3_host_prog = "$HOME/.micromamba/bin/python"
vim.g.node_host_prog = "$HOME/.volta/tools/shared/neovim/bin/cli.js"

-- Appearance
opt.termguicolors = true
opt.background = "dark"
cmd("autocmd VimEnter * highlight NormalFloat guibg=none")

-- Line number
opt.number = true
opt.relativenumber = true
opt.numberwidth = 6
opt.signcolumn = "yes"
-- Color settings aren't respected when using a colorscheme until after "VimEnter"
-- Ref: https://www.reddit.com/r/neovim/comments/me35u9/lua_config_to_set_highlight/
cmd("autocmd VimEnter * highlight LineNr guibg=none")
cmd("autocmd VimEnter * highlight CursorLineNr guibg=none")

-- Line indicator
opt.cursorline = true
opt.colorcolumn = { 101 }
cmd("autocmd VimEnter * highlight CursorLine guibg=11")

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Window split
opt.splitright = true
opt.splitbelow = true

-- Search
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
cmd("autocmd VimEnter * highlight Search guifg=none gui=bold,underline")
cmd("autocmd vimEnter * highlight IncSearch guifg=none gui=bold,underline")

-- Other
opt.mouse = "a"
opt.wildmenu = true
opt.wildignore:append({
	"*.swp",
	"*.swo",
	"*.swn",
	"*.zip",
	"*.png",
	"*.jpg",
	"*jpeg",
	"*pdf",
	".git",
	"__pycache__",
})
opt.scrolloff = 8
opt.cmdheight = 2
opt.autoread = true
opt.timeoutlen = 500
opt.iskeyword:remove({ "_", "A-Z" })
opt.bufhidden = "unload"
opt.hidden = true

-- Jump to the last position when opening a file
cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
