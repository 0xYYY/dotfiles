local utils = require("utils")

utils.map("n", "<Leader>l", "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>")
utils.map("n", "<Leader>j", "<cmd>lua require'hop'.hint_lines()<cr>")
utils.map("v", "<Leader>l", "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>")
utils.map("v", "<Leader>j", "<cmd>lua require'hop'.hint_lines()<cr>")

utils.map(
	"n",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
)
utils.map(
	"n",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
)
utils.map(
	"v",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
)
utils.map(
	"v",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
)

require("hop").setup({
	keys = "asdfghjklqwertyuiop",
	uppercase_labels = true,
})
