local utils = require("utils")

utils.map("n", "<C-_>", ":NvimTreeToggle<CR>")
utils.map("i", "<C-_>", "<ESC>:NvimTreeToggle<CR>")

local tree_cb = require("nvim-tree.config").nvim_tree_callback
require("nvim-tree").setup({
	hijack_cursor = true,
	sync_root_with_cwd = false,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	view = {
		width = 32,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = "x", cb = tree_cb("vsplit") },
				{ key = "v", cb = tree_cb("split") },
			},
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			symlink_arrow = "->",
			glyphs = {
				bookmark = "",
				git = {
					unstaged = "~",
					staged = "",
					unmerged = "",
					renamed = "ﲖ",
					untracked = "",
					deleted = "✗",
					ignored = "◌",
				},
			},
		},
		highlight_git = true,
		highlight_opened_files = "3",
		add_trailing = true,
		group_empty = true,
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
})

-- Kepmap
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
