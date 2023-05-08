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
vim.g.barbar_auto_setup = false
require("barbar").setup({
	-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
	hide = { extensions = true, inactive = false },

	icons = {
		-- Configure the base icons on the bufferline.
		-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
		buffer_index = true,
		buffer_number = false,
		button = "",
		-- Enables / disables diagnostic symbols
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "!" },
			[vim.diagnostic.severity.WARN] = { enabled = false },
			[vim.diagnostic.severity.INFO] = { enabled = false },
			[vim.diagnostic.severity.HINT] = { enabled = false },
		},
		gitsigns = {
			added = { enabled = true, icon = "+" },
			changed = { enabled = true, icon = "~" },
			deleted = { enabled = true, icon = "-" },
		},
		filetype = {
			-- Sets the icon's highlight group.
			-- If false, will use nvim-web-devicons colors
			custom_colors = false,

			-- Requires `nvim-web-devicons` if `true`
			enabled = true,
		},
		separator = { left = "", right = "" },

		-- -- Configure the icons on the bufferline when modified or pinned.
		-- -- Supports all the base icon options.
		-- modified = { button = "●" },
		-- pinned = { button = "車", filename = true, separator = { right = "" } },

		-- -- Configure the icons on the bufferline based on the visibility of a buffer.
		-- -- Supports all the base icon options, plus `modified` and `pinned`.
		-- alternate = { filetype = { enabled = false } },
		-- current = { buffer_index = true },
		inactive = { button = "×", separator = { right = "", left = "" } },
		-- visible = { modified = { buffer_number = false } },
	},
})

-- Highlight
local colors = require("colors")
vim.api.nvim_set_hl(0, "BufferCurrent", { bg = colors.base03, fg = colors.base3, bold = true })
vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "BufferCurrentIndex", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = colors.base03, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BufferCurrentTarget", { bg = colors.base03, fg = colors.red })

vim.api.nvim_set_hl(0, "BufferVisible", { bg = colors.base03, fg = colors.base1, bold = true })
vim.api.nvim_set_hl(0, "BufferVisibleSign", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "BufferVisibleIndex", { link = "BufferVisible" })
vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = colors.base03, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BufferVisibleTarget", { bg = colors.base03, fg = colors.red })

vim.api.nvim_set_hl(0, "BufferInactive", { bg = colors.base03, fg = colors.base01, italic = true })
vim.api.nvim_set_hl(0, "BufferInactiveSign", { fg = colors.base03 })
vim.api.nvim_set_hl(0, "BufferInactiveIndex", { link = "BufferInactive" })
vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = colors.base03, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BufferInactiveTarget", { bg = colors.base03, fg = colors.red })

vim.api.nvim_set_hl(0, "BufferTabpages", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferTabpageFill", { link = "BufferCurrent" })
vim.api.nvim_set_hl(0, "BufferOffset", { link = "BufferCurrent" })
