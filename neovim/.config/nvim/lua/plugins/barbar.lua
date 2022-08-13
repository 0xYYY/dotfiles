local utils = require("utils")

-- Move to previous/next
utils.map("n", "<Leader>,", ":BufferPrevious<CR>")
utils.map("n", "<Leader>.", ":BufferNext<CR>")
utils.map("n", "<Left>", ":BufferPrevious<CR>")
utils.map("n", "<Right>", ":BufferNext<CR>")

-- Re-order to previous/next
utils.map("n", "<Leader><", ":BufferMovePrevious<CR>")
utils.map("n", "<Leader>>", ":BufferMoveNext<CR>")

-- Goto buffer in position...
utils.map("n", "<Leader>1", ":BufferGoto 1<CR>")
utils.map("n", "<Leader>2", ":BufferGoto 2<CR>")
utils.map("n", "<Leader>3", ":BufferGoto 3<CR>")
utils.map("n", "<Leader>4", ":BufferGoto 4<CR>")
utils.map("n", "<Leader>5", ":BufferGoto 5<CR>")
utils.map("n", "<Leader>6", ":BufferGoto 6<CR>")
utils.map("n", "<Leader>7", ":BufferGoto 7<CR>")
utils.map("n", "<Leader>8", ":BufferGoto 8<CR>")
utils.map("n", "<Leader>9", ":BufferGoto 9<CR>")
utils.map("n", "<Leader>0", ":BufferLast<CR>")

-- Jump to buffer
utils.map("n", "<Leader>b", ":BufferPick<CR>")

-- Close buffer
utils.map("n", "<Leader>x", ":BufferClose<CR>")

-- Options
vim.g.bufferline = {
	-- Enable/disable animations
	animation = true,

	-- Enable/disable auto-hiding the tab bar when there is a single buffer
	auto_hide = true,

	-- Enable/disable current/total tabpages indicator (top right corner)
	tabpages = true,

	-- Enable/disable close button
	closable = true,

	-- Enables/disable clickable tabs
	--  - left-click: go to buffer
	--  - middle-click: delete buffer
	clickable = true,

	-- Excludes buffers from the tabline
	exclude_ft = {},
	exclude_name = {},

	-- Enable/disable icons
	-- if set to 'numbers', will show buffer index in the tabline
	-- if set to 'both', will show buffer index and icons in the tabline
	icons = "both",

	-- If set, the icon color will follow its corresponding buffer
	-- highlight group. By default, the Buffer*Icon group is linked to the
	-- Buffer* group (see Highlighting below). Otherwise, it will take its
	-- default value as defined by devicons.
	icon_custom_colors = false,

	-- Configure icons on the bufferline.
	icon_separator_active = "",
	icon_separator_inactive = "",
	icon_close_tab = "",
	icon_close_tab_modified = "",
	icon_pinned = "車",

	-- If true, new buffers will be inserted at the end of the list.
	-- Default is to insert after current buffer.
	insert_at_end = false,

	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 1,

	-- Sets the maximum buffer name length.
	maximum_length = 30,

	-- If set, the letters for each buffer in buffer-pick mode will be
	-- assigned based on their name. Otherwise or in case all letters are
	-- already assigned, the behavior is to assign letters in order of
	-- usability (see order below)
	semantic_letters = true,

	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustement
	-- for other layouts.
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

	-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
	-- where X is the buffer number. But only a static string is accepted here.
	no_name_title = nil,
}

-- Integration with NvimTree
local nvim_tree_events = require("nvim-tree.events")
local bufferline_state = require("bufferline.state")

local function get_tree_size()
	return require("nvim-tree.view").View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
	bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("Resize", function()
	bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("TreeClose", function()
	bufferline_state.set_offset(0)
end)

-- Highlight
local colors = require("colors")
vim.api.nvim_set_hl(0, "BufferCurrent", { bg = colors.base03, fg = colors.base3, bold = true })
vim.api.nvim_set_hl(0, "BufferCurrentSign", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferCurrentIndex", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = colors.base03, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BufferCurrentTarget", { bg = colors.base03, fg = colors.red })

vim.api.nvim_set_hl(0, "BufferVisible", { bg = colors.base03, fg = colors.base1, bold = true })
vim.api.nvim_set_hl(0, "BufferVisibleSign", { link = "BufferVisible" })
vim.api.nvim_set_hl(0, "BufferVisibleIndex", { link = "BufferVisible" })
vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = colors.base03, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BufferVisibleTarget", { bg = colors.base03, fg = colors.red })

vim.api.nvim_set_hl(0, "BufferInactive", { bg = colors.base03, fg = colors.base01, italic = true })
vim.api.nvim_set_hl(0, "BufferInactiveSign", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferInactiveIndex", { link = "BufferInactive" })
vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = colors.base03, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BufferInactiveTarget", { bg = colors.base03, fg = colors.red })

vim.api.nvim_set_hl(0, "BufferTabpages", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferTabpageFill", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferOffset", { link = "BufferCurrent" })
