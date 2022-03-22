local utils = require("utils")

require("tmux").setup({
	copy_sync = {
		-- enables copy sync and overwrites all register actions to
		-- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
		enable = false,

		-- TMUX >= 3.2: yanks (and deletes) will get redirected to system
		-- clipboard by tmux
		redirect_to_clipboard = false,

		-- offset controls where register sync starts
		-- e.g. offset 2 lets registers 0 and 1 untouched
		register_offset = 0,

		-- sync clipboard overwrites vim.g.clipboard to handle * and +
		-- registers. If you sync your system clipboard without tmux, disable
		-- this option!
		sync_clipboard = false,

		-- syncs deletes with tmux clipboard as well, it is adviced to
		-- do so. Nvim does not allow syncing registers 0 and 1 without
		-- overwriting the unnamed register. Thus, ddp would not be possible.
		sync_deletes = false,
	},
	navigation = {
		enable_default_keybindings = true,
	},
})

utils.map("i", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]], { noremap = false })
utils.map("i", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]], { noremap = false })
utils.map("i", "<C-k>", [[<cmd>lua require("tmux").move_bottom()<cr>]], { noremap = false })
utils.map("i", "<C-j>", [[<cmd>lua require("tmux").move_top()<cr>]], { noremap = false })

utils.map("n", "<A-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { noremap = false })
utils.map("n", "<A-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { noremap = false })
utils.map("n", "<A-Up>", [[<cmd>lua require("tmux").resize_up()<cr>]], { noremap = false })
utils.map("n", "<A-Down>", [[<cmd>lua require("tmux").resize_down()<cr>]], { noremap = false })

utils.map("i", "<A-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { noremap = false })
utils.map("i", "<A-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { noremap = false })
utils.map("i", "<A-Up>", [[<cmd>lua require("tmux").resize_up()<cr>]], { noremap = false })
utils.map("i", "<A-Down>", [[<cmd>lua require("tmux").resize_down()<cr>]], { noremap = false })
