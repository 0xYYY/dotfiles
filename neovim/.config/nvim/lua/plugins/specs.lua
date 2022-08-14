local colors = require("colors")
local utils = require("utils")

vim.api.nvim_set_hl(0, "Specs", { bg = colors.base02 })

require("specs").setup({
	show_jumps = false,
	min_jump = 30,
	popup = {
		delay_ms = 0, -- delay before popup displays
		inc_ms = 30, -- time increments used for fade/resize effects
		blend = 0, -- starting blend, between 0-100 (fully transparent), see :h winblend
		width = 10,
		winhl = "Specs",
		fader = require("specs").linear_fader,
		resizer = require("specs").shrink_resizer,
	},
	ignore_filetypes = {},
	ignore_buftypes = {
		nofile = true,
	},
})

utils.map("n", "n", 'n:lua require("specs").show_specs()<CR>')
utils.map("n", "N", 'n:lua require("specs").show_specs()<CR>')
